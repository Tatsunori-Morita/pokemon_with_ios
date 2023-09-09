//
//  pokemon_with_ios_widget.swift
//  pokemon_with_ios_widget
//
//  Created by Tatsunori on 2022/07/02.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> PokemonEntry {
        PokemonEntry(
            date: Date(),
            entity: PokemonEntityPreviewFactory.createPreviewEntity(),
            isNew: true,
            configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PokemonEntry) -> ()) {
        let entry = PokemonEntry(
            date: Date(),
            entity: PokemonEntityPreviewFactory.createPreviewEntity(),
            isNew: true,
            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let config = DomainConfig()
        let repository: IRepository = RealmRepository()
        let savedEntity = repository.getEntityBy(no: try! PokemonEntity.IdValue(id: config.number))
        let isNew = (savedEntity == nil)
        if !isNew {
            repository.delete(entity: savedEntity!)
        }

        let apiService = PokemonApiService(domainConfig: config)

        apiService.fetch(url: apiService.pokemonURL) { (pokemon: Pokemon) in
            var pokemonTypes: [PokemonType] = []
            apiService.fetch(url: apiService.pokemonSpeciesURL) { (pokemonSpecies: PokemonSpecies) in
                guard let typeElements = pokemon.types else { return }
                let pokemonTypesGroup = DispatchGroup()
                typeElements.forEach { typeElement in
                    pokemonTypesGroup.enter()
                    if let url = typeElement.type?.url {
                        apiService.fetch(url: url) { (type: PokemonType) in
                            pokemonTypes.append(type)
                            pokemonTypesGroup.leave()
                        }
                    }
                }

                pokemonTypesGroup.notify(queue: .main) {
                    let currentDate = Date()
                    let factory = PokemonEntityFactory(
                        pokemon: pokemon,
                        pokemonSpecies: pokemonSpecies,
                        pokemonTypes: pokemonTypes)

                    let entity = factory.createEntity()
                    repository.add(entity: entity)
                    
                    let entry = PokemonEntry(
                        date: currentDate,
                        entity: entity,
                        isNew: isNew,
                        configuration: configuration)

                    let timeline = Timeline(entries: [entry], policy: .after(getDate(to: currentDate)))
                    completion(timeline)
                }
            }
        }
    }
    
    private func getDate(to :Date) -> Date {
#if DEBUG
        return Calendar.current.date(byAdding: .minute, value: 15, to: to)!
#else
        return Calendar.current.date(byAdding: .hour, value: 24, to: to)!
#endif
    }
}

struct PokemonEntry: TimelineEntry {
    var date: Date
    var entity: PokemonEntity
    var isNew: Bool
    let configuration: ConfigurationIntent
}

struct pokemon_with_ios_widgetEntryView : View {
    @AppStorage("colorSchemeMode", store: UserDefaults(suiteName: "group.com.tatsunori.morita.pokemon-with-ios"))
    private var _selectedColorSchemeMode: ColorSchemeMode = .light
    @Environment(\.locale)
    private var locale: Locale
    @Environment(\.colorScheme)
    private var colorScheme
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geo in
            ZStack {
                PokemonContentView(viewModel: PokemonContentViewModel(
                    viewConfig: ViewConfig(
                        locale: locale,
                        isDarkMode: colorScheme == .dark,
                        domainConfig: DomainConfig()),
                    pokemonEntity: entry.entity,
                    isApp: false, isNew: entry.isNew))
            }
        }
        .environment(\.colorScheme, _selectedColorSchemeMode == .dark ? .dark : .light)
        .widgetURL(URL(string: "\(entry.entity.id)"))
    }
}

@main
struct pokemon_with_ios_widget: Widget {
    let kind: String = "pokemon_with_ios_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            pokemon_with_ios_widgetEntryView(entry: entry)
        }
        .configurationDisplayName("configurationDisplayName")
        .description("description")
        .supportedFamilies([.systemLarge])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    private static let _entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        Group {
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    entity: _entity,
                    isNew: true,
                    configuration: ConfigurationIntent()))
            .background(Color.layout)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .environment(\.locale, .init(identifier: "ja"))
            .previewDisplayName("Japanese")
            
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    entity: _entity,
                    isNew: true,
                    configuration: ConfigurationIntent()))
            .background(Color.layout)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .environment(\.locale, .init(identifier: "en"))
            .previewDisplayName("English")
            
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    entity: _entity,
                    isNew: true,
                    configuration: ConfigurationIntent()))
            .background(Color.layout)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .environment(\.locale, .init(identifier: "ja"))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}

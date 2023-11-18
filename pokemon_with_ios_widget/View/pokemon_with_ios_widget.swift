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
        let apiService = PokemonApiService()
        let repository: IRepository = RealmRepository()
        let savedEntity = repository.getEntityBy(no: try! PokemonEntity.IdValue(id: apiService.getNumber))
        let isNew = (savedEntity == nil)
        if !isNew {
            repository.delete(entity: savedEntity!)
        }

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

struct pokemon_with_ios_widgetEntryView<WidgetViewModel: IWidgetViewModel>: View {
    @ObservedObject var viewModel: WidgetViewModel
    
    var entry: Provider.Entry

    var body: some View {
        let systemConfig = viewModel.getSystemConfig
        let viewModel = PokemonWidgetContentViewModel(
            systemConfig: systemConfig,
            pokemonEntity: entry.entity,
            isNew: entry.isNew)
        
        GeometryReader { geo in
            ZStack {
                PokemonContentView<PokemonContentViewModel>(viewModel: viewModel)
            }
        }
        .widgetURL(URL(string: "\(entry.entity.id)"))
    }
}

@main
struct pokemon_with_ios_widget: Widget {
    let kind: String = "pokemon_with_ios_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            pokemon_with_ios_widgetEntryView(
                viewModel: WidgetViewModel(),
                entry: entry)
        }
        .configurationDisplayName("configurationDisplayName")
        .description("description")
        .supportedFamilies([.systemLarge])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    private static let _entity = PokemonEntityPreviewFactory.createPreviewEntity()
    
    static var previews: some View {
        let widgetEntity = PokemonEntry(
            date: Date(),
            entity: _entity,
            isNew: true,
            configuration: ConfigurationIntent())
        
        let jaViewModel = PreviewWidgetViewModel(
            systemConfig: SystemConfig(languageMode: .ja, colorSchemeMode: .light))
        let enViewModel = PreviewWidgetViewModel(
            systemConfig: SystemConfig(languageMode: .en, colorSchemeMode: .dark))
        
        Group {
            pokemon_with_ios_widgetEntryView<PreviewWidgetViewModel>(
                viewModel: jaViewModel,
                entry: widgetEntity)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("Japanese")
            
            pokemon_with_ios_widgetEntryView<PreviewWidgetViewModel>(
                viewModel: enViewModel,
                entry: widgetEntity)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDisplayName("English")

            pokemon_with_ios_widgetEntryView<PreviewWidgetViewModel>(
                viewModel: jaViewModel,
                entry: widgetEntity)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
        }
    }
}

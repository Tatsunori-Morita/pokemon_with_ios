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
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.loadPokemonData(),
                pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()),
            configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PokemonEntry) -> ()) {
        let entry = PokemonEntry(
            date: Date(),
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: LocalDataManager.shared.loadPokemonData(),
                pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()),
            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let number = Int.random(in: 1 ... 898)
        let viewModel = PokemonApiService(number: number)

        viewModel.fetchPokemon { pokemon in
            viewModel.fetchPokemonSpecies { pokemonSpecies in
                let currentDate = Date()
                let entry = PokemonEntry(
                    date: currentDate,
                    pokemonEntryViewModel: PokemonEntryViewModel(
                        pokemon: pokemon,
                        pokemonSpecies: pokemonSpecies),
                    configuration: configuration)

                let futureDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
                let timeline = Timeline(entries: [entry], policy: .after(futureDate))
                completion(timeline)
            }
        }
    }
}

struct PokemonEntry: TimelineEntry {
    var date: Date
    var pokemonEntryViewModel: PokemonEntryViewModel
    let configuration: ConfigurationIntent
}

struct pokemon_with_ios_widgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemMedium:
            MediumContentView(pokemonEntryViewModel: entry.pokemonEntryViewModel)
        case .systemLarge:
            LargeContentView(pokemonEntryViewModel: entry.pokemonEntryViewModel)
        default:
            fatalError()
        }
    }
}

@main
struct pokemon_with_ios_widget: Widget {
    let kind: String = "pokemon_with_ios_widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            pokemon_with_ios_widgetEntryView(entry: entry)
                .background(.white)
        }
        .configurationDisplayName("Pokemon WITH")
        .description("かわいいポケモンをランダム表示します。")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    pokemonEntryViewModel: PokemonEntryViewModel(
                        pokemon: LocalDataManager.shared.loadPokemonData(),
                        pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()),
                    configuration: ConfigurationIntent()))
            .background(.white)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    pokemonEntryViewModel: PokemonEntryViewModel(
                        pokemon: LocalDataManager.shared.loadPokemonData(),
                        pokemonSpecies: LocalDataManager.shared.loadPokemonSpeciesData()),
                    configuration: ConfigurationIntent()))
            .background(.white)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

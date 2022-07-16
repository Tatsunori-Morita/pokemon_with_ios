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
                pokemon: loadPokemonData(),
                pokemonSpecies: loadPokemonSpeciesData()),
            configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PokemonEntry) -> ()) {
        let entry = PokemonEntry(
            date: Date(),
            pokemonEntryViewModel: PokemonEntryViewModel(
                pokemon: loadPokemonData(),
                pokemonSpecies: loadPokemonSpeciesData()),
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
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("No.\(entry.pokemonEntryViewModel.getId)")
                        .foregroundColor(.black)
                        .bold()
                    Text(entry.pokemonEntryViewModel.getName)
                        .foregroundColor(.black)
                        .font(.system(size: 24))
                        .bold()
                        .padding(.bottom, 10)
                    Text(entry.pokemonEntryViewModel.getGenera)
                        .foregroundColor(.black)
                    HStack {
                        Text("たかさ:")
                            .bold()
                            .foregroundColor(.black)
                        Text("\(entry.pokemonEntryViewModel.getHeight)m")
                            .foregroundColor(.black)
                    }
                    HStack {
                        Text("おもさ:")
                            .bold()
                            .foregroundColor(.black)
                        Text("\(entry.pokemonEntryViewModel.getWeight)kg")
                            .foregroundColor(.black)
                    }
                }

                if let url = URL(string: entry.pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.top, 30)
            .padding(.leading, 30)
            .padding(.trailing, 30)

            Divider()

            Text(entry.pokemonEntryViewModel.getFlavorTextEntry)
                .font(.system(size: 20))
                .lineSpacing(8)
                .foregroundColor(.black)
                .padding(.top)
            Spacer()
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    pokemonEntryViewModel: PokemonEntryViewModel(
                        pokemon: loadPokemonData(),
                        pokemonSpecies: loadPokemonSpeciesData()),
                    configuration: ConfigurationIntent()))
            .background(.white)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

func loadPokemonData() -> Pokemon {
    guard let url = Bundle.main.url(forResource: "Pokemon", withExtension: "json") else {
        fatalError()
    }

    guard
        let data = try? Data(contentsOf: url),
        let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data)
    else {
        fatalError()
    }
    return pokemon
}

func loadPokemonSpeciesData() -> PokemonSpecies {
    guard let url = Bundle.main.url(forResource: "PokemonSpecies", withExtension: "json") else {
        fatalError()
    }

    guard
        let data = try? Data(contentsOf: url),
        let pokemonSpecies = try? JSONDecoder().decode(PokemonSpecies.self, from: data)
    else {
        fatalError()
    }
    return pokemonSpecies
}

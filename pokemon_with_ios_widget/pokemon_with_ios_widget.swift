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
        PokemonEntry(date: Date(), pokemonEntryViewModel: PokemonEntryViewModel(pokemon: loadData()), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PokemonEntry) -> ()) {
        let entry = PokemonEntry(date: Date(), pokemonEntryViewModel: PokemonEntryViewModel(pokemon: loadData()), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let number = Int.random(in: 1 ... 151)
        let viewModel = PokemonApiService(number: number)

        viewModel.fetchPokemon { pokemon in
            let currentDate = Date()
            let entry = PokemonEntry(
                date: currentDate,
                pokemonEntryViewModel: PokemonEntryViewModel(pokemon: pokemon),
                configuration: configuration)

            let futureDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
            let timeline = Timeline(entries: [entry], policy: .after(futureDate))
            completion(timeline)
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
            VStack {
                if let url = URL(string: entry.pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Text(entry.pokemonEntryViewModel.getName)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(.bottom)
            }
            .ignoresSafeArea()
        case .systemLarge:
            VStack {
                if let url = URL(string: entry.pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Text(entry.pokemonEntryViewModel.getName)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(.bottom)
            }
        default:
            VStack {
                if let url = URL(string: entry.pokemonEntryViewModel.getFrontDefault),
                   let imageData = try! Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Text(entry.pokemonEntryViewModel.getName)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(.bottom)
            }
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
//        .supportedFamilies([.systemSmall])
    }
}

struct pokemon_with_ios_widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            pokemon_with_ios_widgetEntryView(
                entry: PokemonEntry(
                    date: Date(),
                    pokemonEntryViewModel: PokemonEntryViewModel(pokemon: loadData()),
                    configuration: ConfigurationIntent()))
            .background(.white)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}

func loadData() -> Pokemon {
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

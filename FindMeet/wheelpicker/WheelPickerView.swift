//
//  WheelPickerView.swift
//  FindMeet
//
//  Created by Cintia Raquel on 29/08/26.
//

import SwiftUI

//para declarar uma struct generica
//Label pode ser qualquer tipo que esteja em conformidade com o protocolo View
struct WheelPickerView<Label: View> : View{
    var range: ClosedRange<Int>
//define os valores possíveis que o "wheel picker" vai exibir
    @Binding var selectedValue: Int
    var config: WheelPickerViewConfig = .init()
    @ViewBuilder var label: (Int) -> Label
//isso permite que quem use o WheelPickerView customize completamente como cada número do intervalo é exibido visualmente
    
    @State private var activePosition: Int?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            //remove line-width de width
            let width = size.width - (config.strokeStyle.lineWidth)
            let dia = min(max(size.width, size.height), width)
            let radius = dia/2
            
            WheelPath(size, radius: radius)
                .stroke(config.strokeColor, style: config.strokeStyle)
                .overlay {
                    wheelPickerScrollView(size: size, radius: radius)
                    }
                .compositingGroup()
            //remove line-width de height(usando offset)
                .offset(y: -config.strokeStyle.lineWidth/2)
                //.background(.red)
        }
        .frame(height: config.height)
        //configuração dos dados iniciais e alteração dos dados públicos para a propriedade selectedValue
        .task{
            guard activePosition == nil else { return }
            activePosition = selectedValue
        }
        .onChange(of: activePosition) { oldValue, newValue in
            if let newValue, selectedValue != newValue {
                selectedValue = newValue
            }
        }
        .onChange(of: selectedValue) { oldValue, newValue in
            if activePosition != newValue {
                activePosition = newValue
            }
        }
        .onScrollPhaseChange { oldPhase, newPhase in
            if newPhase == .idle {
                Task {
                    activePosition = nil
                    try? await Task.sleep(for: .seconds(0))
                    activePosition = selectedValue
                }
            }
        }
    }
    //Wheel Picker
    //Wheel Shape
    @ViewBuilder
    //para poder ter mais de uma view na mesma funcao
    func wheelPickerScrollView(size: CGSize, radius: CGFloat) -> some View {
        ///Interação de clipping e limitação
        
        let wheelShape = WheelPath(size, radius: radius)
            .strokedPath(config.strokeStyle)
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(ticks, id: \.self) { tick in
                    TickView(tick, size: size, radius: radius)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    
                }
            }
            .scrollTargetLayout()
            //para saber identificar os itens dentro do scroll
        }
        .scrollIndicators(.hidden)
        //esconde a barra de rolagem
        .scrollClipDisabled(true)
        //desativa o corte padrao do sistema que ultrapassa os limites
        .safeAreaPadding(.horizontal, (size.width - 8)/2)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .alwaysByOne))
        
        .scrollPosition(id: $activePosition, anchor: .center )
        //le a posicao do scroll e pode escrever a posicao que voce quer
        //.center serve para deixar marcado no centro do arco inicialmente
        .clipShape(wheelShape)
        //para as barras nao sairem do campo delimitado
        .contentShape(wheelShape)
        //para so ser possivel arrastar no campo delimitado
        .overlay(alignment: .bottom) {
            let strokeWidth = config.strokeStyle.lineWidth
            let halfStrokeWidth = strokeWidth/2
            //seta
            VStack(spacing: -5) {
                Capsule()
                    .fill(config.activeTint)
                    .frame(width: 5, height:  strokeWidth)
                Circle()
                    .fill(config.activeTint)
                    .frame(width: 10, height: 10)
            }
            .offset(y: -radius + halfStrokeWidth)
            
        }
        .overlay(alignment: .bottom) {
            if let activePosition {
                label(activePosition)
                    .frame(
                        maxWidth: radius,
                        maxHeight: radius - (config.strokeStyle.lineWidth/2))
            }
            
            
        }
    }
    
    @ViewBuilder
    func TickView(_ value: Int, size: CGSize, radius: CGFloat) -> some View{
       let strokeWidth = config.strokeStyle.lineWidth
       let halfStrokeWidth = strokeWidth/2
       ///larger tick for the given frequency
        let isLargeTick = (ticks.firstIndex(of: value) ?? 0) % config.largeTickFrequency == 0
        
        GeometryReader{proxy in
            //Rotacionando a marca para alinhar com o formato das bordas do traço!
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let midX = proxy.frame(in: .scrollView(axis: .horizontal)).midX
            let halfWidth = size.width/2
            // Left - Right
            let progress = max(min(midX / halfWidth, 1), -1)
            //-180...180
            let rotation = Angle(degrees: progress * 180)
            /***rotation é um valor do tipo angulo que define quantos graus a view deve girar
             ***/
            
            Capsule()
                .fill(config.inactiveTint)
                .offset(y: -radius + halfStrokeWidth)
                .rotationEffect(rotation, anchor: .bottom)
            /***.rotationEffect gira uma view em torno de um ponto especifico
             anchor/; .bottom: a barrinha gira como um ponteiro fixo na base, seguindo perfeitamente a curva do arco, dando aquele efeito 3D de "roda de verdade" onde cada marcação se inclina radialmente para fora conforme se afasta do centro.***/
                .offset(x: -minX)
        }
        .frame(width: 3, height: isLargeTick ? (strokeWidth - 10 ) : halfStrokeWidth)
        //a cada 10 barrinhas a proxima é maior
        .frame(width: 8, alignment: .leading)
    }
    
    func WheelPath(_ size: CGSize, radius: CGFloat) -> Path {
        return Path { path in
            path.addArc(
                center: .init(x: size.width/2 , y: size.height),
                radius: radius ,
                startAngle: .degrees(180) ,
                endAngle: .degrees(0),
                clockwise: false
            )
        }
        
    }
    
    //converting range into array of int
    var ticks: [Int] {
        stride(from: range.lowerBound, through: range.upperBound, by: 1).compactMap({$0})
    }
    
    
    
    struct WheelPickerViewConfig {
        var activeTint: Color = .primary
        var inactiveTint: Color = Color.gray
        var largeTickFrequency: Int = 10
        var strokeStyle: StrokeStyle = .init(
            lineWidth: 50,
            lineCap: .round,
            lineJoin: .round
        )
        var strokeColor: Color = .black.opacity(0.1)
        var height: CGFloat = 200
        //Adicionar mais propriedades a partir do que voce precisar!
        
        
    }
}

#Preview{
    ContentTeste()
}

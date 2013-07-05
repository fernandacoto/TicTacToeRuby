    class Game
      def initialize
       @ganador = false
       @entrada = ""
       @casilla = 0
       @jugador = 1
       @gato = [1,2,3,4,5,6,7,8,9]
       @soluciones = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
       @jug_uno = [0,0,0,0,0,0]
       @jug_dos = [0,0,0,0,0]
       @prueba = Array.new
      end

      def pintar
        puts "  #{@gato[0]} | #{@gato[1]} | #{@gato[2]}"
        puts "-------------"
        puts "  #{@gato[3]} | #{@gato[4]} | #{@gato[5]}"
        puts "-------------"
        puts "  #{@gato[6]} | #{@gato[7]} | #{@gato[8]}"
      end

      def largoreal(arreglo)
        indice = 0
        while arreglo[indice] != 0
          indice += 1
        end
        return indice
      end

      def jugada
        if @jugador == 1
          @gato[@casilla - 1] = "X"
          @jug_uno[largoreal(@jug_uno)] = @casilla
          pintar
          @jugador = 2
          #ganador
        else
          @gato[@casilla - 1] = "O"
          @jug_dos[largoreal(@jug_dos)] = @casilla
          pintar
          @jugador = 1
         # ganador
        end
      end

      def partida_usuarios
        movimientos = 0
        pintar
        while movimientos < 9 && @ganador == false do
          puts "Jugador #{@jugador} digite el numero de la casilla"
          @entrada = gets
          @casilla = @entrada.to_i
          if @casilla > 0 && @casilla < 10
            if @gato[@casilla - 1] != 0
              @gato[@casilla - 1] = 0
              jugada
            else
              puts "Esa casilla ya esta ocupada"
            end
          else
            puts "Posicion fuera de rango"
          end
          movimientos += 1
        end
        puts "Fin del juego"
      end

      def cc
        e = gets
        if Integer(e)
          puts "entero"
        end
      rescue
            puts "waaaaaaaaaaa"
     end

  end
prueba = Game.new()
prueba.partida_usuarios

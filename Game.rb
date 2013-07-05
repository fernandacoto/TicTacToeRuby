      class Game
      def initialize
       @ganador = false
       @entrada = ""
       @casilla = 0
       @jugador = 1
       @gato = [1,2,3,4,5,6,7,8,9]
       @soluciones = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
       @jug_uno = [2,1,6,5,9,0]
       @jug_dos = [0,0,0,0,0]
       @prueba = Array.new
       @indicador = 0
       @solucion_parcial = false
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
          ganador(@jug_uno)
        else
          @gato[@casilla - 1] = "O"
          @jug_dos[largoreal(@jug_dos)] = @casilla
          pintar
          @jugador = 1
          ganador(@jug_dos)
        end
        if @solucion_parcial == true
          puts "FIN DEL JUEGO HAY UN GANADOR!"
        end
      end

      def partida_usuarios
        movimientos = 0
        pintar
        while movimientos < 9 && @ganador == false do
          puts "Jugador #{@jugador} digite el numero de la casilla"
          @entrada = gets#falta validar que sea un entero
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

      def ganador(arreglo)
        @indicador = 0
        @solucion_parcial = false
        largo = largoreal(arreglo)
        if largo >= 3
          indice_soluciones = 0
          while @indicador < largo && @solucion_parcial == false
            while indice_soluciones < 8 && @solucion_parcial == false
              buscasolucion(indice_soluciones,arreglo)
              indice_soluciones += 1
            end
            @indicador += 1
          end
          return @solucion_parcial
        else
          return false
        end
      end

      def buscasolucion(indice_arreglo_soluciones, arreglo_jugador)
        if @soluciones[indice_arreglo_soluciones][0] == arreglo_jugador[@indicador]
          puts "SOLUCIONES #{@soluciones[indice_arreglo_soluciones][0]} == JUGADOR #{arreglo_jugador[@indicador]}"
          acierto_primera_columna(indice_arreglo_soluciones,arreglo_jugador)
        end
        if @soluciones[indice_arreglo_soluciones][1] == arreglo_jugador[@indicador]
          puts "SOLUCIONES #{@soluciones[indice_arreglo_soluciones][1]} == JUGADOR #{arreglo_jugador[@indicador]}"
          acierto_segunda_columna(indice_arreglo_soluciones,arreglo_jugador)
        end
        if @soluciones[indice_arreglo_soluciones][2] == arreglo_jugador[@indicador]
          puts "SOLUCIONES #{@soluciones[indice_arreglo_soluciones][2]} == JUGADOR #{arreglo_jugador[@indicador]}"
          acierto_tercera_columna(indice_arreglo_soluciones,arreglo_jugador)
        end
      end

      def acierto_primera_columna(indice_en_soluciones,arreglo_jugador)
        avance_soluciones = indice_en_soluciones + 1
        while avance_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][1] == arreglo_jugador[avance_soluciones]
             puts "SOLUCIONES segunda posicion #{@soluciones[indice_arreglo_soluciones][1]} == JUGADOR #{arreglo_jugador[@indicador]}"
             primeracol_tercer_acierto_coltres(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          if @soluciones[indice_en_soluciones][2] == arreglo_jugador[avance_soluciones]
             puts "SSOLUCIONES segunda posicion #{@soluciones[indice_arreglo_soluciones][2]} == JUGADOR #{arreglo_jugador[@indicador]}"
             primeracol_tercer_acierto_coldos(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          avance_soluciones += 1
        end
      end

      def acierto_segunda_columna(indice_en_soluciones,arreglo_jugador)
        avance_soluciones = indice_en_soluciones + 1
        while avance_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][0] == arreglo_jugador[avance_soluciones]
            segundacol_tercer_acierto_coltres(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          if @soluciones[indice_en_soluciones][2] == arreglo_jugador[avance_soluciones]
            segundacol_tercer_acierto_coluno(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          avance_soluciones += 1
        end
      end

      def acierto_tercera_columna(indice_en_soluciones,arreglo_jugador)
        avance_soluciones = indice_en_soluciones + 1
        while avance_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][0] == arreglo_jugador[avance_soluciones]
            tercercol_tercer_acierto_coldos(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          if @soluciones[indice_en_soluciones][1] == arreglo_jugador[avance_soluciones]
            tercercol_tercer_acierto_coluno(indice_en_soluciones,avance_soluciones,arreglo_jugador)
          end
          avance_soluciones += 1
        end
      end

      def primeracol_tercer_acierto_coltres(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][2] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def segundacol_tercer_acierto_coltres(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][2] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def tercercol_tercer_acierto_coldos(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][1] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def primeracol_tercer_acierto_coldos(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][1] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def segundacol_tercer_acierto_coluno(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][0] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def tercercol_tercer_acierto_coluno(indice_en_soluciones,avance_soluciones,arreglo_jugador)
        indice_soluciones = avance_soluciones + 1
        while indice_soluciones < largoreal(arreglo_jugador) && @solucion_parcial == false
          if @soluciones[indice_en_soluciones][0] == arreglo_jugador[indice_soluciones]
            @solucion_parcial = true
          else
            indice_soluciones += 1
          end
        end
      end

      def pru
        puts "INICIO"
        ganador(@jug_uno)
        puts @solucion_parcial
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
prueba.pru
#prueba.partida_usuarios

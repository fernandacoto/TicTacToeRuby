require_relative "./Winner_logic.rb"
require_relative "./Computer_logic.rb"
class Console_Output
  $existe_ganador
  $fila
  $columna
  $instancia_logica_ganador
  $numero_casillas_ocupadas
  $instancia_logica_computadora
  $cantidad_maxima_movidas
  $primer_jugador
  $segundo_jugador

  def initialize
    @tablero = [[" "," "," "],[" "," "," "],[" "," "," "]]
    $primer_jugador = 1
    $segundo_jugador = 2
    @jugador = $primer_jugador
    $cantidad_maxima_movidas = 9
    $instancia_logica_ganador = Logica_Ganador.new()
  end
  
  def hacer_menu
    initialize
    mostrar_opciones
    print "opcion =" 
    opcion = gets.to_i
    while opcion != 4 
      procesar_opcion(opcion)
    end
    exit
  end

  def mostrar_opciones
    print "Tic Tac Toe \n"
    print "1. Instrucciones \n"
    print "2. Usuario-Usuario \n"
    print "3. Usuario-Computadora \n"
    print "4. Salir \n"
  end
 
  def procesar_opcion(opcion)
    if opcion == 1
      mostrar_instrucciones
    else
      if opcion == 2
        iniciar_partida_usuario
      else
        if opcion == 3
          iniciar_partida_computadora_usuario
        end
      end
    end
  end

  def mostrar_instrucciones
    print "Para jugar debe de digitar el numero de la fila y columna en la cual desea jugar\n"
    print "0 0 | 0 1 | 0 2 \n"
    print "--------------- \n"
    print "1 0 | 1 1 | 1 2 \n"
    print "--------------- \n"
    print "2 0 | 2 1 | 2 2 \n"
    print "Por ejemplo para seleccionar la casilla central, cuando se me pide la fila digito 1 y cuando es la columna digito 1 \n"
    print "Presione cualquier tecla para continuar \n"
    gets 
    hacer_menu
  end
  
  def iniciar_partida_usuario 
    $numero_casillas_ocupadas = 0
    $existe_ganador = false
    pintar_tablero
    while $numero_casillas_ocupadas < $cantidad_maxima_movidas && $existe_ganador == false
      print "Jugador #{@jugador} digite el numero de la casilla a marcar\n"
      hacer_validaciones
      selecionar_jugador
      $existe_ganador = $instancia_logica_ganador.iniciar_buscar_ganador(@tablero,@jugador,$numero_casillas_ocupadas)
      chequear_ganador
      $numero_casillas_ocupadas +=1
    end
    hacer_menu
  end

  def pintar_tablero #falta modificar
    print " #{@tablero[0][0]} | #{@tablero[0][1]} | #{@tablero[0][2]}\n"
    print "------------\n"
    print " #{@tablero[1][0]} | #{@tablero[1][1]} | #{@tablero[1][2]}\n"
    print "------------\n"
    print " #{@tablero[2][0]} | #{@tablero[2][1]} | #{@tablero[2][2]}\n"
  end

  def hacer_validaciones
    validar_entrada("fila ")
    validar_entrada("columna ")
    validar_disponibilidad
  end

  def validar_entrada(argumento)
    print argumento
    es_fila(argumento)
  end

  def es_fila(argumento)
    if argumento == "fila "
      $fila = gets.to_i
      while $fila > 2
        validar_entrada(argumento)
      end
    else
      $columna = gets.to_i
      while $columna > 2
        validar_entrada(argumento)
      end
    end
  end

  def validar_disponibilidad
    while @tablero[$fila][$columna] != " "
      print "Casilla Ocupada seleccione otra\n"
      validar_entrada("fila ")
      validar_entrada("columna ")
    end
  end

  def selecionar_jugador #falta modificar
    if @jugador == $primer_jugador
      @tablero[$fila][$columna] = "X"
      @jugador = $segundo_jugador
    else
      @tablero[$fila][$columna] = "O"
      @jugador = $primer_jugador
    end
    pintar_tablero
  end

  def chequear_ganador
    if $existe_ganador == true
      print "FIN DEL JUEGO HAY UN GANADOR \n"
      if @jugador == 1
        print "Felicidades jugador 1\n"
      else
        print "Felicidades jugador 2\n"
      end
    end
  end

  def iniciar_partida_computadora_usuario
    $numero_casillas_ocupadas = 0
    $existe_ganador = false
    pintar_tablero
    while $numero_casillas_ocupadas < $cantidad_maxima_movidas && $existe_ganador == false
      if @jugador == $primer_jugador
        realizar_movida_usuario
      else
        realizar_movida_computadora
      end
      $numero_casillas_ocupadas +=1
    end
    hacer_menu
  end

  def realizar_movida_usuario
    print "Jugador #{@jugador} digite el numero de la casilla a marcar\n"
      hacer_validaciones
      @tablero[$fila][$columna] = "X"
      @jugador = $segundo_jugador
  end

  def realizar_movida_computadora
    @jugador = $primer_jugador
    $existe_ganador = $instancia_logica_ganador.iniciar_buscar_ganador(@tablero,@jugador,$numero_casillas_ocupadas)
    chequear_ganador
    @jugador = $segundo_jugador
    if $existe_ganador != true
      continuar_juego
    end
  end

  def continuar_juego
    $instancia_logica_computadora = Logica_Computadora.new()
    arreglo_resultado = Array.new()
    arreglo_resultado = $instancia_logica_computadora.iniciar_movida_computadora(@tablero,$numero_casillas_ocupadas)
    @tablero[arreglo_resultado[0]][arreglo_resultado[1]] = "O"
    $existe_ganador = $instancia_logica_ganador.iniciar_buscar_ganador(@tablero,@jugador,$numero_casillas_ocupadas)
    chequear_ganador
    @jugador = $primer_jugador
    pintar_tablero
  end

end
jugar = Console_Output.new()
#jugar.iniciar_partida_usuario
jugar.hacer_menu
#pinta.iniciar_partida_computadora_usuario

require_relative "./LG.rb"
require_relative "./LC.rb"
class Console_Output
  $ganador
  $fila
  $columna
  $busca_ganador
  $movimientos
  $computadora

  def initialize
    @gato = [[" "," "," "],[" "," "," "],[" "," "," "]]
    @jugador = 1
    $busca_ganador = Logica_Ganador.new()
  end
  ##menu
  
  def partida_usuarios #cambiar nombre inicia con verbo y q hace
    $movimientos = 0
    $ganador = false
    pintar_gato
    while $movimientos < 9 && $ganador == false
      print "Jugador #{@jugador} digite el numero de la casilla a marcar\n"
      validar_fila # todos los validar en un solo metodo
      validar_columna
      validar_disponibilidad
      jugada
      $ganador = $busca_ganador.ganador(@gato,@jugador,$movimientos)
      hay_ganador
      $movimientos +=1
    end
  end

  def partida_computadora_usuario
    $movimientos = 0
    $ganador = false
    pintar_gato
    while $movimientos < 9 && $ganador == false
      if @jugador == 1
        turno_usuario
      else
        turno_computadora
      end
      $movimientos +=1
    end
  end

  def turno_usuario
    print "Jugador #{@jugador} digite el numero de la casilla a marcar\n"
      validar_fila
      validar_columna
      validar_disponibilidad
      @gato[$fila][$columna] = "X"
      $ganador = $busca_ganador.ganador(@gato,@jugador,$movimientos)
      hay_ganador
      @jugador = 2
  end

  def turno_computadora # movimientos cambiar por casillas_ocupadas y gato por tablero
    $computadora = Logica_Computadora.new()
    arreglo_resultado = Array.new()
    arreglo_resultado = $computadora.movida_computadora(@gato,$movimientos)
    @gato[arreglo_resultado[0]][arreglo_resultado[1]] = "O"
    $ganador = $busca_ganador.ganador(@gato,@jugador,$movimientos)
    hay_ganador
    @jugador = 1
    pintar_gato
  end

  def validar_fila
    print "Fila ="
    $fila = gets.to_i
    while $fila != 0 && $fila != 1 && $fila != 2
      print "Fila debe de ser 0,1 o 2\n"
      print "Fila ="
      $fila = gets.to_i
    end
  end

  def validar_columna
    print "Columna ="
    $columna = gets.to_i
    while $columna != 0 && $columna != 1 && $columna != 2
      print "Columna debe de ser 0,1 o 2\n"
      print "Columna ="
      $columna = gets.to_i
    end
  end

  def validar_disponibilidad
    while @gato[$fila][$columna] != " "
      print "Casilla Ocupada seleccione otra\n"
      validar_fila
      validar_columna
    end
  end

  def jugada # cambiar jugador por "string"
    if @jugador == 1
      @gato[$fila][$columna] = "X"
      @jugador = 2
    else
      @gato[$fila][$columna] = "O"
      @jugador = 1
    end
    $ganador = $busca_ganador.ganador(@gato,@jugador,$movimientos)
    hay_ganador
    pintar_gato
  end

  def hay_ganador
    if $ganador == true
      print "FIN DEL JUEGO HAY UN GANADOR \n"
      if @jugador == 1
        print "Felicidades jugador 1\n"
      else
        print "Felicidades jugador 2\n"
      end
    end
  end

  def pintar_gato
    print " #{@gato[0][0]} | #{@gato[0][1]} | #{@gato[0][2]}\n"
    print "------------\n"
    print " #{@gato[1][0]} | #{@gato[1][1]} | #{@gato[1][2]}\n"
    print "------------\n"
    print " #{@gato[2][0]} | #{@gato[2][1]} | #{@gato[2][2]}\n"
  end
end

pinta = Console_Output.new()
pinta.partida_usuarios
#pinta.partida_computadora_usuario

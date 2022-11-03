class Actividad {

	var property participantes = #{}
	var club
	
	method evaluacion()

	method destacado()

	method participa(participante) {
		return participantes.contains(participante)
	}

	method sancionar()

	method esExperimentado() {
		return false
	}
	
	method esPrestigiosa() {
		return false
	}

}

class ActividadSocial inherits Actividad {

	var property socioOrganizador
	var suspendida = false
	const valorEvaluacion

	method suspendida() = suspendida

	override method destacado() = socioOrganizador

	override method evaluacion() {
		return if (suspendida) 0 else valorEvaluacion
	}

	override method sancionar() {
		suspendida = true
	}

	method reanudar() {
		suspendida = false
	}
	
	override method esPrestigiosa() {
		return participantes.count({participante => participante.esEstrella()}) >= 5
	}

}

class Equipo inherits Actividad {

	var property capitan
	var sanciones = 0
	var property campeonatos = 0

	method sanciones() = sanciones

	override method destacado() = capitan

	override method evaluacion() {
		return campeonatos * 5 + participantes.size() * 2 + self.puntajePorEstrella(capitan) - sanciones * self.descuentoPorSanciones()
	}

	method puntajePorEstrella(jugador) {
		return if (jugador.esEstrella()) 5 else 0
	}

	method descuentoPorSanciones() {
		return 20
	}

	override method sancionar() {
		sanciones += 1
	}

	override method esExperimentado() {
		return participantes.all({ participante => participante.esExprimentado() })
	}

}

class EquipoFutbol inherits Equipo {

	override method evaluacion() {
		return super() + self.puntajePorEstrellas()
	}

	method puntajePorEstrellas() {
		return participantes.sum({ participante => self.puntajePorEstrella(participante) })
	}

	override method descuentoPorSanciones() {
		return 30
	}
	
	method agregarParticipante(jugador) {
		participantes.add(jugador)
		club.addSocio(jugador)
		jugador.resetear()
	}

}


create TABLE perfil_usuario
(
	idusuario integer references usuario(idusuario),
	id_perfil integer references perfil(id_perfil)
)
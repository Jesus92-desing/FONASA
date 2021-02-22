const seleccion = document.getElementById('seleccion')
const formulario = document.getElementById('form_paciente')

function Formulario(){
    alert('Se estan ocultando los botones')
}

seleccion.addEventListener('blur',() => {
    console.log('Al perder el foco')
})
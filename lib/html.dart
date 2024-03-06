const html = '''

<!DOCTYPE html>
<html lang="en">
<script type="module" src="model-viewer.min.js" defer></script>
<script type="module">
  const modelViewer = document.querySelector("model-viewer")

  // the scope of any functions or variables declared in a module script is local to the module itself.
  // exposing this function by attaching it to the global window object
  window.switchSrc = (model) => {
    const base = model;
    modelViewer.src = base + '.glb';
    modelViewer.poster = base + '.webp';
  };
</script>


<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Document</title>
  <style>
    :not(:defined)>* {
      display: none;
    }

    html,
    body,
    model-viewer {
      width: 100%;
      height: 100%;
      margin: 0;
      padding: 0;
      overflow-x: hidden;
    }

/*
  strange enough, if we uncommented these it will works
  fine on iOS
*/
/*
    .slider {
      width: 100%;
      position: absolute;
      bottom: 16px;
    }

    .slide {
      width: 100px;
      height: 100px;
      visibility: hidden;
    }
*/
  </style>
</head>

<body>
  <model-viewer src="Chair.glb" poster="Chair.webp" tone-mapping="commerce" disable-tap shadow-intensity="1"
    camera-controls touch-action="none" alt="A 3D model carousel">

   <!-- 
   
   <div class="slider">
      <button class="slide">
  -->

  </model-viewer>
</body>

</html>


''';

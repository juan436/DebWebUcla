<main class="devwebucla">
    <h2 class="devwebucla__heading"><?php echo $titulo; ?></h2>
    <p class="devwebucla__descripcion">Conoce la conferencia más importante de Latinoamérica</p>

    <div class="devwebucla__grid">
        <div <?php aos_animacion(); ?> class="devwebucla__imagen">
            <picture>
                <source srcset="build/img/sobre_devwebcamp.avif" type="image/avif">
                <source srcset="build/img/sobre_devwebcamp.webp" type="image/webp">
                <img loading="lazy" width="200" height="300" src="build/img/sobre_devwebucamp.jpg" alt="Imagen devwebucla">
            </picture>
        </div>

        <div  class="devwebucla__contenido">
            <p <?php aos_animacion(); ?>  class="devwebucla__texto">Aliquam est elit, condimentum a justo vitae, fringilla dignissim tortor. 
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. 
                Nullam quis lorem eget felis dignissim dignissim. Praesent ac lorem convallis, ultrices neque quis, cursus lorem.
            </p>
            
            <p <?php aos_animacion(); ?>  class="devwebucla__texto">Aliquam est elit, condimentum a justo vitae, fringilla dignissim tortor. 
                Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. 
                Nullam quis lorem eget felis dignissim dignissim. Praesent ac lorem convallis, ultrices neque quis, cursus lorem.
            </p>
        </div>
    </div>
</main>
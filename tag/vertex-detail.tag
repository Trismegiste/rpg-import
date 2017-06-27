<vertex-detail id="selected">
    <article>
        <div class="pure-g">
            <div class="pure-u-11-12">
                <mark class="hashtag">{vertex.hashtag}</mark>
            </div>
            <div class="pure-u-1-12">
                <a href="#">E</a>
            </div>
            <div class="pure-u-11-12">
                <hashtag-decorator str="{vertex.sentence}" inner="{ vertex.pk }"></hashtag-decorator>
            </div>
            <div class="pure-u-1-12">
                <a href="#">E</a>
            </div>
            <div class="pure-u-11-12">
                <ul class="outer-vertex">
                    <li each="{ RpgImpro.document.getVertexBySource(vertex.pk) }">
                        <a href="#show/{pk}">{ hashtag }</a>
                    </li>
                </ul>
            </div>
            <div class="pure-u-1-12">
                <a href="#">+</a>
            </div>
            <div class="pure-u-11-12">
                <ul class="inner-vertex">
                    <li each="{ RpgImpro.document.getVertexByTarget(vertex.pk) }">
                        <a href="#show/{pk}">{ hashtag }</a>
                    </li>
                </ul>
            </div>
            <div class="pure-u-1-12">
                <a href="#">+</a>
            </div>
        </div>
    </article>
    <script>

    </script>
</vertex-detail>
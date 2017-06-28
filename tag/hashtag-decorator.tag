<hashtag-decorator>
    <nav each="{ chunk in opts.str.split(' ') }">
        <span if="{ chunk[0] != '#' }">{chunk}</span>
        <a if="{ chunk[0] == '#' }" href="#new/{ chunk.substr(1) }/inner/{ parent.opts.inner }" class="hashtag">{chunk.substr(1)}</a>
    </nav>
</hashtag-decorator>
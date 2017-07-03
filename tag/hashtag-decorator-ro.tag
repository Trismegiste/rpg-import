<hashtag-decorator-ro class="sentence">
    <nav>
        <virtual each="{ chunk in opts.str.split(' ') }">
            <span if="{ chunk[0] != '#' }">{chunk}</span>
            <span if="{ chunk[0] == '#' }" class="hashtag">{chunk.substr(1)}</span>
        </virtual>
    </nav>
</hashtag-decorator-ro>
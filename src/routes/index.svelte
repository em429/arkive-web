<style>
.read {
    background-color: theme('colors.zinc.200');
    opacity: 0.23;
}
</style>

<script context="module">
async function load({}) {}
</script>

<script>
export let archived_pages = []
</script>

<div class="text-sm m-auto max-w-4xl px-2">
    <form action="/" method="post">

        <label class='switch'>
          <input name="unread_only" type='checkbox'>
          <span>Unread only</span>
        </label>
        
        <br />
        <input
            class="@low field mt-2 w-auto rounded-none ~purple"
            placeholder="Search"
            type="text"
            name="url"
        />

        <input class="button rounded-none ~purple @high" type="submit" />
    </form>

    <table
        class="mytable border-1 mt-4 w-full table-auto border border-purple-200 text-xs shadow-lg shadow-purple-500/10 sm:text-sm"
    >
        <thead class="pb-0 text-xs">
            <tr>
                <th class="border">Timestamp</th>
                <th class="border">URL</th>
                <th class="w-10 border">
                    <span class="icon mx-1 w-4">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M10.496 2.132a1 1 0 00-.992 0l-7 4A1 1 0 003 8v7a1 1 0 100 2h14a1 1 0 100-2V8a1 1 0 00.496-1.868l-7-4zM6 9a1 1 0 00-1 1v3a1 1 0 102 0v-3a1 1 0 00-1-1zm3 1a1 1 0 012 0v3a1 1 0 11-2 0v-3zm5-1a1 1 0 00-1 1v3a1 1 0 102 0v-3a1 1 0 00-1-1z"
                                clip-rule="evenodd"
                            />
                        </svg>
                    </span>
                </th>
                <th class="w-8 border text-center ">a.t</th>
                <th class="w-8 border">
                    <span class="icon w-4">
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5"
                            viewBox="0 0 20 20"
                            fill="currentColor"
                        >
                            <path
                                fill-rule="evenodd"
                                d="M9.504 1.132a1 1 0 01.992 0l1.75 1a1 1 0 11-.992 1.736L10 3.152l-1.254.716a1 1 0 11-.992-1.736l1.75-1zM5.618 4.504a1 1 0 01-.372 1.364L5.016 6l.23.132a1 1 0 11-.992 1.736L4 7.723V8a1 1 0 01-2 0V6a.996.996 0 01.52-.878l1.734-.99a1 1 0 011.364.372zm8.764 0a1 1 0 011.364-.372l1.733.99A1.002 1.002 0 0118 6v2a1 1 0 11-2 0v-.277l-.254.145a1 1 0 11-.992-1.736l.23-.132-.23-.132a1 1 0 01-.372-1.364zm-7 4a1 1 0 011.364-.372L10 8.848l1.254-.716a1 1 0 11.992 1.736L11 10.58V12a1 1 0 11-2 0v-1.42l-1.246-.712a1 1 0 01-.372-1.364zM3 11a1 1 0 011 1v1.42l1.246.712a1 1 0 11-.992 1.736l-1.75-1A1 1 0 012 14v-2a1 1 0 011-1zm14 0a1 1 0 011 1v2a1 1 0 01-.504.868l-1.75 1a1 1 0 11-.992-1.736L16 13.42V12a1 1 0 011-1zm-9.618 5.504a1 1 0 011.364-.372l.254.145V16a1 1 0 112 0v.277l.254-.145a1 1 0 11.992 1.736l-1.735.992a.995.995 0 01-1.022 0l-1.735-.992a1 1 0 01-.372-1.364z"
                                clip-rule="evenodd"
                            />
                        </svg>
                    </span>
                </th>
                <th class="w-8 border text-center">read?</th>
                <th class="w-8 border text-center">del</th>
            </tr>
        </thead>
        <tbody class="text-xs">
            {#each archived_pages as page}
                <tr class="hover:bg-purple-100" class:read={page.read == 1}>
                    <td class="">{page.timestamp}</td>
                    <td class="break-all"><a href="https://{page.url}">{page.url}</a></td>
                    <td class="w-8"
                        ><a href={page.internet_archive_url}>
                            <span class="icon ml-1 w-5 ~purple">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-6 w-6"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor"
                                    stroke-width="2"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
                                    />
                                </svg>
                            </span>
                        </a></td
                    >
                    <td class="w-8">
                        {#if page.archive_today_url == null}{:else}
                            <a href="#">link</a>
                        {/if}
                    </td>

                    <td class="w-8">
                        {#if page.freeze_dry == null}{:else}
                            <a href="#"> link </a>
                        {/if}
                    </td>

                    <td class="w-8">
                        {#if page.read == 0}
                            <form action="/toggle_read" method="post">
                                <input type="text" name="url" value={page.url} hidden />
                                <button
                                    class="icon ml-2 w-5 ~green"
                                    name="read"
                                    value="1"
                                >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        className="h-6 w-6"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke="currentColor"
                                        strokeWidth={2}
                                    >
                                        <path
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                            d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"
                                        />
                                    </svg>
                                </button>
                            </form>
                        {:else}
                            <form action="/toggle_read" method="post">
                                <input type="text" name="url" value={page.url} hidden />
                                <button
                                    class="icon ml-2 w-5 ~green"
                                    name="read"
                                    value="0"
                                >
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        class="h-5 w-5"
                                        viewBox="0 0 20 20"
                                        fill="currentColor"
                                    >
                                        <path
                                            fill-rule="evenodd"
                                            d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                            clip-rule="evenodd"
                                        />
                                    </svg>
                                </button>
                            </form>
                        {/if}
                    </td>
                    <td>
                        <form action="/delete" method="post">
                            <input type="text" name="url" value={page.url} hidden />
                            <button class="icon w-4 ~red" name="read" value="0">
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-6 w-6"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke="currentColor"
                                    stroke-width="2"
                                >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                                    />
                                </svg>
                            </button>
                        </form>
                    </td>
                </tr>
            {/each}
        </tbody>
    </table>
</div>

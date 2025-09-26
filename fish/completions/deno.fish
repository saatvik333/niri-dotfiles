# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_deno_global_optspecs
	string join \n no-check= import-map= no-remote no-npm node-modules-dir= vendor= conditions= c/config= no-config r/reload= lock= no-lock frozen= cert= unsafely-ignore-certificate-errors= preload= A/allow-all P/permission-set= R/allow-read= deny-read= W/allow-write= deny-write= N/allow-net= deny-net= E/allow-env= deny-env= S/allow-sys= deny-sys= allow-run= deny-run= allow-ffi= deny-ffi= allow-hrtime deny-hrtime no-prompt I/allow-import= deny-import= inspect= inspect-brk= inspect-wait= allow-scripts= cached-only location= v8-flags= seed= enable-testing-features-do-not-use trace-ops= eszip-internal-do-not-use check= watch= watch-hmr= watch-exclude= no-clear-screen ext= env-file= no-code-cache coverage= connected= unstable unstable-bare-node-builtins unstable-broadcast-channel unstable-bundle unstable-byonm unstable-cron unstable-detect-cjs unstable-ffi unstable-fs unstable-http unstable-kv unstable-lazy-dynamic-imports unstable-lockfile-v5 unstable-net unstable-no-legacy-abort unstable-node-globals unstable-npm-lazy-caching unstable-otel unstable-process unstable-raw-imports unstable-sloppy-imports unstable-subdomain-wildcards unstable-temporal unstable-unsafe-proto unstable-vsock unstable-webgpu unstable-worker-options h/help= V/version L/log-level= q/quiet
end

function __fish_deno_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_deno_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_deno_using_subcommand
	set -l cmd (__fish_deno_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c deno -n "__fish_deno_needs_command" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_needs_command" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_needs_command" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_needs_command" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_needs_command" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_needs_command" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_needs_command" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_needs_command" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_needs_command" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_needs_command" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_needs_command" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_needs_command" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_needs_command" -s P -l permission-set -r
complete -c deno -n "__fish_deno_needs_command" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_needs_command" -l deny-read -r -F
complete -c deno -n "__fish_deno_needs_command" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_needs_command" -l deny-write -r -F
complete -c deno -n "__fish_deno_needs_command" -s N -l allow-net -r
complete -c deno -n "__fish_deno_needs_command" -l deny-net -r
complete -c deno -n "__fish_deno_needs_command" -s E -l allow-env -r
complete -c deno -n "__fish_deno_needs_command" -l deny-env -r
complete -c deno -n "__fish_deno_needs_command" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_needs_command" -l deny-sys -r
complete -c deno -n "__fish_deno_needs_command" -l allow-run -r
complete -c deno -n "__fish_deno_needs_command" -l deny-run -r
complete -c deno -n "__fish_deno_needs_command" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_needs_command" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_needs_command" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_needs_command" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_needs_command" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_needs_command" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_needs_command" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_needs_command" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_needs_command" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_needs_command" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_needs_command" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_needs_command" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_needs_command" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_needs_command" -l watch -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_needs_command" -l watch-hmr -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_needs_command" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_needs_command" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_needs_command" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_needs_command" -l coverage -d 'Collect coverage profile data into DIR. If DIR is not specified, it uses \'coverage/\'.   This option can also be set via the DENO_COVERAGE_DIR environment variable.' -r -F
complete -c deno -n "__fish_deno_needs_command" -l connected -r
complete -c deno -n "__fish_deno_needs_command" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_needs_command" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_needs_command" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_needs_command" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_needs_command" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_needs_command" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_needs_command" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_needs_command" -l allow-hrtime
complete -c deno -n "__fish_deno_needs_command" -l deny-hrtime
complete -c deno -n "__fish_deno_needs_command" -l no-prompt
complete -c deno -n "__fish_deno_needs_command" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_needs_command" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_needs_command" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_needs_command" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_needs_command" -l no-code-cache -d 'Disable V8 code cache feature'
complete -c deno -n "__fish_deno_needs_command" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_needs_command" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_needs_command" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_needs_command" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_needs_command" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_needs_command" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_needs_command" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_needs_command" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_needs_command" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_needs_command" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_needs_command" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_needs_command" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_needs_command" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_needs_command" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_needs_command" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_needs_command" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_needs_command" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_needs_command" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_needs_command" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_needs_command" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_needs_command" -s V -l version -d 'Print version'
complete -c deno -n "__fish_deno_needs_command" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_needs_command" -a "run" -d 'Run a JavaScript or TypeScript program, or a task or script.  By default all programs are run in sandbox without access to disk, network or ability to spawn subprocesses.   deno run https://examples.deno.land/hello-world.ts  Grant permission to read from disk and listen to network:   deno run --allow-read --allow-net jsr:@std/http/file-server  Grant permission to read allow-listed files from disk:   deno run --allow-read=/etc jsr:@std/http/file-server  Grant all permissions:   deno run -A jsr:@std/http/file-server  Specifying the filename \'-\' to read the file from stdin.   curl https://examples.deno.land/hello-world.ts | deno run -  Read more: https://docs.deno.com/go/run'
complete -c deno -n "__fish_deno_needs_command" -a "serve" -d 'Run a server defined in a main module  The serve command uses the default exports of the main module to determine which servers to start.  Start a server defined in server.ts:   deno serve server.ts  Start a server defined in server.ts, watching for changes and running on port 5050:   deno serve --watch --port 5050 server.ts  Read more: https://docs.deno.com/go/serve'
complete -c deno -n "__fish_deno_needs_command" -a "add" -d 'Add dependencies to your configuration file.   deno add jsr:@std/path  You can also add npm packages:   deno add npm:react  Or multiple dependencies at once:   deno add jsr:@std/path jsr:@std/assert npm:chalk'
complete -c deno -n "__fish_deno_needs_command" -a "remove" -d 'Remove dependencies from the configuration file.   deno remove @std/path  You can remove multiple dependencies at once:   deno remove @std/path @std/assert '
complete -c deno -n "__fish_deno_needs_command" -a "bench" -d 'Run benchmarks using Deno\'s built-in bench tool.  Evaluate the given files, run all benches declared with \'Deno.bench()\' and report results to standard output:   deno bench src/fetch_bench.ts src/signal_bench.ts  If you specify a directory instead of a file, the path is expanded to all contained files matching the glob {*_,*.,}bench.{js,mjs,ts,mts,jsx,tsx}:   deno bench src/  Read more: https://docs.deno.com/go/bench'
complete -c deno -n "__fish_deno_needs_command" -a "bundle" -d 'Output a single JavaScript file with all dependencies.    deno bundle jsr:@std/http/file-server -o file-server.bundle.js  If no output file is given, the output is written to standard output:    deno bundle jsr:@std/http/file-server '
complete -c deno -n "__fish_deno_needs_command" -a "cache" -d 'Cache and compile remote dependencies.  Download and compile a module with all of its static dependencies and save them in the local cache, without running any code:   deno cache jsr:@std/http/file-server  Future runs of this module will trigger no downloads or compilation unless --reload is specified  Read more: https://docs.deno.com/go/cache'
complete -c deno -n "__fish_deno_needs_command" -a "check" -d 'Download and type-check without execution.    deno check jsr:@std/http/file-server  Unless --reload is specified, this command will not re-download already cached dependencies  Read more: https://docs.deno.com/go/check'
complete -c deno -n "__fish_deno_needs_command" -a "clean" -d 'Remove the cache directory ($DENO_DIR)'
complete -c deno -n "__fish_deno_needs_command" -a "compile" -d 'Compiles the given script into a self contained executable.    deno compile --allow-read --allow-net jsr:@std/http/file-server   deno compile --output file_server jsr:@std/http/file-server  Any flags specified which affect runtime behavior will be applied to the resulting binary.  This allows distribution of a Deno application to systems that do not have Deno installed. Under the hood, it bundles a slimmed down version of the Deno runtime along with your JavaScript or TypeScript code.  Cross-compiling to different target architectures is supported using the --target flag. On the first invocation of `deno compile`, Deno will download the relevant binary and cache it in $DENO_DIR.  Read more: https://docs.deno.com/go/compile '
complete -c deno -n "__fish_deno_needs_command" -a "completions" -d 'Output shell completion script to standard output.    deno completions bash > /usr/local/etc/bash_completion.d/deno.bash   source /usr/local/etc/bash_completion.d/deno.bash'
complete -c deno -n "__fish_deno_needs_command" -a "coverage" -d 'Print coverage reports from coverage profiles.  Collect a coverage profile with deno test:   deno test --coverage=cov_profile  Print a report to stdout:   deno coverage cov_profile  Include urls that start with the file schema and exclude files ending with test.ts and test.js, for an url to match it must match the include pattern and not match the exclude pattern:   deno coverage --include="^file:" --exclude="test\\.(ts|js)" cov_profile  Write a report using the lcov format:   deno coverage --lcov --output=cov.lcov cov_profile/  Generate html reports from lcov:   genhtml -o html_cov cov.lcov  Read more: https://docs.deno.com/go/coverage'
complete -c deno -n "__fish_deno_needs_command" -a "doc" -d 'Show documentation for a module.  Output documentation to standard output:     deno doc ./path/to/module.ts  Output documentation in HTML format:     deno doc --html --name="My library" ./path/to/module.ts  Lint a module for documentation diagnostics:     deno doc --lint ./path/to/module.ts  Target a specific symbol:     deno doc ./path/to/module.ts MyClass.someField  Show documentation for runtime built-ins:     deno doc     deno doc --filter Deno.Listener  Read more: https://docs.deno.com/go/doc'
complete -c deno -n "__fish_deno_needs_command" -a "deploy"
complete -c deno -n "__fish_deno_needs_command" -a "eval" -d 'Evaluate JavaScript from the command line.   deno eval "console.log(\'hello world\')"  To evaluate as TypeScript:   deno eval --ext=ts "const v: string = \'hello\'; console.log(v)"  This command has implicit access to all permissions.  Read more: https://docs.deno.com/go/eval'
complete -c deno -n "__fish_deno_needs_command" -a "fmt" -d 'Auto-format various file types.   deno fmt myfile1.ts myfile2.ts  Supported file types are:   JavaScript, TypeScript, Markdown, JSON(C) and Jupyter Notebooks  Supported file types which are behind corresponding unstable flags (see formatting options):   HTML, CSS, SCSS, SASS, LESS, YAML, Svelte, Vue, Astro and Angular  Format stdin and write to stdout:   cat file.ts | deno fmt -  Check if the files are formatted:   deno fmt --check  Ignore formatting code by preceding it with an ignore comment:   // deno-fmt-ignore  Ignore formatting a file by adding an ignore comment at the top of the file:   // deno-fmt-ignore-file  Read more: https://docs.deno.com/go/fmt'
complete -c deno -n "__fish_deno_needs_command" -a "init" -d 'scaffolds a basic Deno project with a script, test, and configuration file'
complete -c deno -n "__fish_deno_needs_command" -a "info" -d 'Show information about a module or the cache directories.  Get information about a module:   deno info jsr:@std/http/file-server  The following information is shown:   local: Local path of the file   type: JavaScript, TypeScript, or JSON   emit: Local path of compiled source code (TypeScript only)   dependencies: Dependency tree of the source file  Read more: https://docs.deno.com/go/info'
complete -c deno -n "__fish_deno_needs_command" -a "install" -d 'Installs dependencies either in the local project or globally to a bin directory.  Local installation  Add dependencies to the local project\'s configuration (deno.json / package.json) and installs them in the package cache. If no dependency is specified, installs all dependencies listed in the config file. If the --entrypoint flag is passed, installs the dependencies of the specified entrypoint(s).    deno install   deno install jsr:@std/bytes   deno install npm:chalk   deno install --entrypoint entry1.ts entry2.ts  Global installation  If the --global flag is set, installs a script as an executable in the installation root\'s bin directory.    deno install --global --allow-net --allow-read jsr:@std/http/file-server   deno install -g https://examples.deno.land/color-logging.ts  To change the executable name, use -n/--name:   deno install -g --allow-net --allow-read -n serve jsr:@std/http/file-server  The executable name is inferred by default:   - Attempt to take the file stem of the URL path. The above example would     become file_server.   - If the file stem is something generic like main, mod, index or cli,     and the path has no parent, take the file name of the parent path. Otherwise     settle with the generic name.   - If the resulting name has an @... suffix, strip it.  To change the installation root, use --root:   deno install -g --allow-net --allow-read --root /usr/local jsr:@std/http/file-server  The installation root is determined, in order of precedence:   - --root option   - DENO_INSTALL_ROOT environment variable   - $HOME/.deno  These must be added to the path manually if required.'
complete -c deno -n "__fish_deno_needs_command" -a "i" -d 'Installs dependencies either in the local project or globally to a bin directory.  Local installation  Add dependencies to the local project\'s configuration (deno.json / package.json) and installs them in the package cache. If no dependency is specified, installs all dependencies listed in the config file. If the --entrypoint flag is passed, installs the dependencies of the specified entrypoint(s).    deno install   deno install jsr:@std/bytes   deno install npm:chalk   deno install --entrypoint entry1.ts entry2.ts  Global installation  If the --global flag is set, installs a script as an executable in the installation root\'s bin directory.    deno install --global --allow-net --allow-read jsr:@std/http/file-server   deno install -g https://examples.deno.land/color-logging.ts  To change the executable name, use -n/--name:   deno install -g --allow-net --allow-read -n serve jsr:@std/http/file-server  The executable name is inferred by default:   - Attempt to take the file stem of the URL path. The above example would     become file_server.   - If the file stem is something generic like main, mod, index or cli,     and the path has no parent, take the file name of the parent path. Otherwise     settle with the generic name.   - If the resulting name has an @... suffix, strip it.  To change the installation root, use --root:   deno install -g --allow-net --allow-read --root /usr/local jsr:@std/http/file-server  The installation root is determined, in order of precedence:   - --root option   - DENO_INSTALL_ROOT environment variable   - $HOME/.deno  These must be added to the path manually if required.'
complete -c deno -n "__fish_deno_needs_command" -a "json_reference"
complete -c deno -n "__fish_deno_needs_command" -a "jupyter" -d 'Deno kernel for Jupyter notebooks'
complete -c deno -n "__fish_deno_needs_command" -a "uninstall" -d 'Uninstalls a dependency or an executable script in the installation root\'s bin directory.   deno uninstall @std/dotenv chalk   deno uninstall --global file_server  To change the installation root, use --root flag:   deno uninstall --global --root /usr/local serve  The installation root is determined, in order of precedence:   - --root option   - DENO_INSTALL_ROOT environment variable   - $HOME/.deno'
complete -c deno -n "__fish_deno_needs_command" -a "outdated" -d 'Find and update outdated dependencies. By default, outdated dependencies are only displayed.  Display outdated dependencies:   deno outdated   deno outdated --compatible  Update dependencies to the latest semver compatible versions:   deno outdated --update Update dependencies to the latest versions, ignoring semver requirements:   deno outdated --update --latest  Filters can be used to select which packages to act on. Filters can include wildcards (*) to match multiple packages.   deno outdated --update --latest "@std/*"   deno outdated --update --latest "react*" Note that filters act on their aliases configured in deno.json / package.json, not the actual package names:   Given "foobar": "npm:react@17.0.0" in deno.json or package.json, the filter "foobar" would update npm:react to   the latest version.   deno outdated --update --latest foobar Filters can be combined, and negative filters can be used to exclude results:   deno outdated --update --latest "@std/*" "!@std/fmt*"  Specific version requirements to update to can be specified:   deno outdated --update @std/fmt@^1.0.2 '
complete -c deno -n "__fish_deno_needs_command" -a "lsp" -d 'The \'deno lsp\' subcommand provides a way for code editors and IDEs to interact with Deno using the Language Server Protocol. Usually humans do not use this subcommand directly. For example, \'deno lsp\' can provide IDEs with go-to-definition support and automatic code formatting.  How to connect various editors and IDEs to \'deno lsp\': https://docs.deno.com/go/lsp'
complete -c deno -n "__fish_deno_needs_command" -a "lint" -d 'Lint JavaScript/TypeScript source code.    deno lint   deno lint myfile1.ts myfile2.js  Print result as JSON:   deno lint --json  Read from stdin:   cat file.ts | deno lint -   cat file.ts | deno lint --json -  List available rules:   deno lint --rules  To ignore specific diagnostics, you can write an ignore comment on the preceding line with a rule name (or multiple):   // deno-lint-ignore no-explicit-any   // deno-lint-ignore require-await no-empty  To ignore linting on an entire file, you can add an ignore comment at the top of the file:   // deno-lint-ignore-file  Read more: https://docs.deno.com/go/lint '
complete -c deno -n "__fish_deno_needs_command" -a "publish" -d 'Publish the current working directory\'s package or workspace to JSR'
complete -c deno -n "__fish_deno_needs_command" -a "repl" -d 'Starts a read-eval-print-loop, which lets you interactively build up program state in the global context. It is especially useful for quick prototyping and checking snippets of code.  TypeScript is supported, however it is not type-checked, only transpiled.'
complete -c deno -n "__fish_deno_needs_command" -a "task" -d 'Run a task defined in the configuration file:   deno task build  List all available tasks (from config files in the current and ancestor directories):   deno task  Evaluate a task from string:   deno task --eval "echo $(pwd)"'
complete -c deno -n "__fish_deno_needs_command" -a "test" -d 'Run tests using Deno\'s built-in test runner.  Evaluate the given modules, run all tests declared with Deno.test() and report results to standard output:   deno test src/fetch_test.ts src/signal_test.ts  Directory arguments are expanded to all contained files matching the glob {*_,*.,}test.{js,mjs,ts,mts,jsx,tsx} or **/__tests__/**:  deno test src/  Read more: https://docs.deno.com/go/test'
complete -c deno -n "__fish_deno_needs_command" -a "types" -d 'Print runtime TypeScript declarations.    deno types > lib.deno.d.ts  The declaration file could be saved and used for typing information.'
complete -c deno -n "__fish_deno_needs_command" -a "update" -d 'Update outdated dependencies.  Update dependencies to the latest semver compatible versions:   deno update Update dependencies to the latest versions, ignoring semver requirements:   deno update --latest  This command is an alias of deno outdated --update  Filters can be used to select which packages to act on. Filters can include wildcards (*) to match multiple packages.   deno update --latest "@std/*"   deno update --latest "react*" Note that filters act on their aliases configured in deno.json / package.json, not the actual package names:   Given "foobar": "npm:react@17.0.0" in deno.json or package.json, the filter "foobar" would update npm:react to   the latest version.   deno update --latest foobar Filters can be combined, and negative filters can be used to exclude results:   deno update --latest "@std/*" "!@std/fmt*"  Specific version requirements to update to can be specified:   deno update @std/fmt@^1.0.2 '
complete -c deno -n "__fish_deno_needs_command" -a "upgrade" -d 'Upgrade deno executable to the given version.  Latest   deno upgrade  Specific version   deno upgrade 1.45.0   deno upgrade 1.46.0-rc.1   deno upgrade 9bc2dd29ad6ba334fd57a20114e367d3c04763d4  Channel   deno upgrade stable   deno upgrade rc   deno upgrade canary  The version is downloaded from https://dl.deno.land and is used to replace the current executable.  If you want to not replace the current Deno executable but instead download an update to a different location, use the --output flag:   deno upgrade --output $HOME/my_deno  Read more: https://docs.deno.com/go/upgrade'
complete -c deno -n "__fish_deno_needs_command" -a "vendor" -d '`deno vendor` was removed in Deno 2.  See the Deno 1.x to 2.x Migration Guide for migration instructions: https://docs.deno.com/runtime/manual/advanced/migrate_deprecations'
complete -c deno -n "__fish_deno_needs_command" -a "help"
complete -c deno -n "__fish_deno_using_subcommand run" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand run" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand run" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand run" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand run" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand run" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand run" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand run" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand run" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand run" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand run" -l watch -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l watch-hmr -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand run" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l coverage -d 'Collect coverage profile data into DIR. If DIR is not specified, it uses \'coverage/\'.   This option can also be set via the DENO_COVERAGE_DIR environment variable.' -r -F
complete -c deno -n "__fish_deno_using_subcommand run" -l connected -r
complete -c deno -n "__fish_deno_using_subcommand run" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand run" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand run" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand run" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand run" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand run" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand run" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand run" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand run" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand run" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand run" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand run" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand run" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand run" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand run" -l no-code-cache -d 'Disable V8 code cache feature'
complete -c deno -n "__fish_deno_using_subcommand run" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand serve" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand serve" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand serve" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand serve" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand serve" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand serve" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l port -d 'The TCP port to serve on. Pass 0 to pick a random free port [default: 8000]' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l host -d 'The TCP address to serve on, defaulting to 0.0.0.0 (all interfaces)' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand serve" -l watch -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l watch-hmr -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand serve" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand serve" -l connected -r
complete -c deno -n "__fish_deno_using_subcommand serve" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand serve" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand serve" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand serve" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand serve" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand serve" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand serve" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand serve" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand serve" -l open -d 'Open the browser on the address that the server is running on.'
complete -c deno -n "__fish_deno_using_subcommand serve" -l parallel -d 'Run multiple server workers in parallel. Parallelism defaults to the number of available CPUs or the value of the DENO_JOBS environment variable'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand serve" -l no-code-cache -d 'Disable V8 code cache feature'
complete -c deno -n "__fish_deno_using_subcommand serve" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand add" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand add" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand add" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand add" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand add" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand add" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand add" -s D -l dev -d 'Add the package as a dev dependency. Note: This only applies when adding to a `package.json` file.'
complete -c deno -n "__fish_deno_using_subcommand add" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand add" -l npm -d 'assume unprefixed package names are npm packages'
complete -c deno -n "__fish_deno_using_subcommand add" -l jsr -d 'assume unprefixed package names are jsr packages'
complete -c deno -n "__fish_deno_using_subcommand remove" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand remove" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand remove" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand remove" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand remove" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand remove" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand bench" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand bench" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand bench" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand bench" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand bench" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand bench" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand bench" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand bench" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l ignore -d 'Ignore files' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l filter -d 'Run benchmarks with this string or regexp pattern in the bench name' -r
complete -c deno -n "__fish_deno_using_subcommand bench" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand bench" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand bench" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand bench" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand bench" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand bench" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand bench" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand bench" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand bench" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand bench" -l json -d 'UNSTABLE: Output benchmark result in JSON format'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-run -d 'Cache bench modules, but don\'t run benchmarks'
complete -c deno -n "__fish_deno_using_subcommand bench" -l permit-no-files -d 'Don\'t return an error code if no files were found'
complete -c deno -n "__fish_deno_using_subcommand bench" -l watch -d 'Watch for file changes and restart process automatically.   Only local files from entry point module graph are watched.'
complete -c deno -n "__fish_deno_using_subcommand bench" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand bundle" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand bundle" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand bundle" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand bundle" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand bundle" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -s o -l output -d 'Output path`' -r -F
complete -c deno -n "__fish_deno_using_subcommand bundle" -l outdir -d 'Output directory for bundled files' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand bundle" -l external -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l format -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l packages -d 'How to handle packages. Accepted values are \'bundle\' or \'external\'' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l inline-imports -d 'Whether to inline imported modules into the importing file [default: true]' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand bundle" -l sourcemap -d 'Generate source map. Accepted values are \'linked\', \'inline\', or \'external\'' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l platform -d 'Platform to bundle for. Accepted values are \'browser\' or \'deno\'' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand bundle" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l minify -d 'Minify the output'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l code-splitting -d 'Enable code splitting'
complete -c deno -n "__fish_deno_using_subcommand bundle" -l watch -d 'Watch and rebuild on changes'
complete -c deno -n "__fish_deno_using_subcommand cache" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand cache" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand cache" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand cache" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand cache" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand cache" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand cache" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand cache" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand cache" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand cache" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand cache" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand check" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand check" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand check" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand check" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand check" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand check" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand check" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand check" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand check" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand check" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand check" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand check" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand check" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand check" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand check" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand check" -l no-code-cache -d 'Disable V8 code cache feature'
complete -c deno -n "__fish_deno_using_subcommand check" -l all -d 'Type-check all code, including remote modules and npm packages'
complete -c deno -n "__fish_deno_using_subcommand check" -l remote -d 'Type-check all modules, including remote ones'
complete -c deno -n "__fish_deno_using_subcommand check" -l doc -d 'Type-check code blocks in JSDoc as well as actual code'
complete -c deno -n "__fish_deno_using_subcommand check" -l doc-only -d 'Type-check code blocks in JSDoc and Markdown only'
complete -c deno -n "__fish_deno_using_subcommand clean" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand clean" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand clean" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand clean" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand clean" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand clean" -s e -l except -d 'Retain cache data needed by the given files'
complete -c deno -n "__fish_deno_using_subcommand clean" -l dry-run -d 'Show what would be removed without performing any actions'
complete -c deno -n "__fish_deno_using_subcommand compile" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand compile" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand compile" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand compile" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand compile" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l include -d 'Includes an additional module or file/directory in the compiled executable.   Use this flag if a dynamically imported module or a web worker main module   fails to load in the executable or to embed a file or directory in the executable.   This flag can be passed multiple times, to include multiple additional modules.' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l exclude -d 'Excludes a file/directory in the compiled executable.   Use this flag to exclude a specific file or directory within the included files.   For example, to exclude a certain folder in the bundled node_modules directory.' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -s o -l output -d 'Output file (defaults to $PWD/<inferred-name>)' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l target -d 'Target OS architecture' -r -f -a "x86_64-unknown-linux-gnu\t''
aarch64-unknown-linux-gnu\t''
x86_64-pc-windows-msvc\t''
x86_64-apple-darwin\t''
aarch64-apple-darwin\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -l icon -d 'Set the icon of the executable on Windows (.ico)' -r
complete -c deno -n "__fish_deno_using_subcommand compile" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand compile" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand compile" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand compile" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand compile" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand compile" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand compile" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand compile" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand compile" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-code-cache -d 'Disable V8 code cache feature'
complete -c deno -n "__fish_deno_using_subcommand compile" -l no-terminal -d 'Hide terminal on Windows'
complete -c deno -n "__fish_deno_using_subcommand completions" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand completions" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand completions" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand coverage" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand coverage" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand coverage" -l ignore -d 'Ignore coverage files' -r -F
complete -c deno -n "__fish_deno_using_subcommand coverage" -l include -d 'Include source files in the report' -r
complete -c deno -n "__fish_deno_using_subcommand coverage" -l exclude -d 'Exclude source files from the report' -r
complete -c deno -n "__fish_deno_using_subcommand coverage" -l output -d 'Exports the coverage report in lcov format to the given file.   If no --output arg is specified then the report is written to stdout.' -r -F
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand coverage" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l lcov -d 'Output coverage report in lcov format'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l html -d 'Output coverage report in HTML format in the given directory'
complete -c deno -n "__fish_deno_using_subcommand coverage" -l detailed -d 'Output coverage report in detailed format in the terminal'
complete -c deno -n "__fish_deno_using_subcommand doc" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand doc" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand doc" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand doc" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand doc" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand doc" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand doc" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l name -d 'The name that will be used in the docs (ie for breadcrumbs)' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l category-docs -d 'Path to a JSON file keyed by category and an optional value of a markdown doc' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l symbol-redirect-map -d 'Path to a JSON file keyed by file, with an inner map of symbol to an external link' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l default-symbol-map -d 'Uses the provided mapping of default name to wanted name for usage blocks' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l output -d 'Directory for HTML documentation output' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand doc" -l filter -d 'Dot separated path to symbol' -r
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand doc" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand doc" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand doc" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand doc" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand doc" -l json -d 'Output documentation in JSON format'
complete -c deno -n "__fish_deno_using_subcommand doc" -l html -d 'Output documentation in HTML format'
complete -c deno -n "__fish_deno_using_subcommand doc" -l strip-trailing-html -d 'Remove trailing .html from various links. Will still generate files with a .html extension'
complete -c deno -n "__fish_deno_using_subcommand doc" -l private -d 'Output private documentation'
complete -c deno -n "__fish_deno_using_subcommand doc" -l lint -d 'Output documentation diagnostics.'
complete -c deno -n "__fish_deno_using_subcommand deploy" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand deploy" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand deploy" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand eval" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand eval" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand eval" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand eval" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand eval" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand eval" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l check -d 'Enable type-checking. This subcommand does not type-check by default   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand eval" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand eval" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand eval" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand eval" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand eval" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand eval" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand eval" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand eval" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand eval" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand eval" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand eval" -s p -l print -d 'print result to stdout'
complete -c deno -n "__fish_deno_using_subcommand fmt" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand fmt" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''
md\t''
json\t''
jsonc\t''
css\t''
scss\t''
sass\t''
less\t''
html\t''
svelte\t''
vue\t''
astro\t''
yml\t''
yaml\t''
ipynb\t''
sql\t''
vto\t''
njk\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -l ignore -d 'Ignore formatting particular source files' -r -F
complete -c deno -n "__fish_deno_using_subcommand fmt" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand fmt" -l use-tabs -d 'Use tabs instead of spaces for indentation [default: false]' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -l line-width -d 'Define maximum line width [default: 80]' -r
complete -c deno -n "__fish_deno_using_subcommand fmt" -l indent-width -d 'Define indentation width [default: 2]' -r
complete -c deno -n "__fish_deno_using_subcommand fmt" -l single-quote -d 'Use single quotes [default: false]' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -l prose-wrap -d 'Define how prose should be wrapped [default: always]' -r -f -a "always\t''
never\t''
preserve\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -l no-semicolons -d 'Don\'t use semicolons except where necessary [default: false]' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand fmt" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l check -d 'Check if the source files are formatted'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l permit-no-files -d 'Don\'t return an error code if no files were found'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l watch -d 'Watch for file changes and restart process automatically.   Only local files from entry point module graph are watched.'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-css -d 'Enable formatting CSS, SCSS, Sass and Less files'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-html -d 'Enable formatting HTML files'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-component -d 'Enable formatting Svelte, Vue, Astro and Angular files'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-yaml -d 'Enable formatting YAML files'
complete -c deno -n "__fish_deno_using_subcommand fmt" -l unstable-sql -d 'Enable formatting SQL files.'
complete -c deno -n "__fish_deno_using_subcommand init" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand init" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand init" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand init" -l npm -d 'Generate a npm create-* project'
complete -c deno -n "__fish_deno_using_subcommand init" -l lib -d 'Generate an example library project'
complete -c deno -n "__fish_deno_using_subcommand init" -l serve -d 'Generate an example project for `deno serve`'
complete -c deno -n "__fish_deno_using_subcommand info" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand info" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand info" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand info" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand info" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand info" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand info" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand info" -l location -d 'Show files used for origin bound APIs like the Web Storage API when running a script with --location=<HREF>' -r -f
complete -c deno -n "__fish_deno_using_subcommand info" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand info" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand info" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand info" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand info" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand info" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand info" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand info" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand info" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand info" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand info" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand info" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand info" -l json -d 'UNSTABLE: Outputs the information in JSON format'
complete -c deno -n "__fish_deno_using_subcommand install" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand install" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand install" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand install" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand install" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand install" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand install" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand install" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand install" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand install" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand install" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand install" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand install" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand install" -s n -l name -d 'Executable file name' -r
complete -c deno -n "__fish_deno_using_subcommand install" -l root -d 'Installation root' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand install" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand install" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand install" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand install" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand install" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand install" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand install" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand install" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand install" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand install" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand install" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand install" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand install" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand install" -s f -l force -d 'Forcefully overwrite existing installation'
complete -c deno -n "__fish_deno_using_subcommand install" -s g -l global -d 'Install a package or script as a globally available executable'
complete -c deno -n "__fish_deno_using_subcommand install" -s e -l entrypoint -d 'Install dependents of the specified entrypoint(s)'
complete -c deno -n "__fish_deno_using_subcommand install" -s D -l dev -d 'Add the package as a dev dependency. Note: This only applies when adding to a `package.json` file.'
complete -c deno -n "__fish_deno_using_subcommand install" -l npm -d 'assume unprefixed package names are npm packages'
complete -c deno -n "__fish_deno_using_subcommand install" -l jsr -d 'assume unprefixed package names are jsr packages'
complete -c deno -n "__fish_deno_using_subcommand i" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand i" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand i" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand i" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand i" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand i" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand i" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand i" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand i" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand i" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand i" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand i" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand i" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand i" -s n -l name -d 'Executable file name' -r
complete -c deno -n "__fish_deno_using_subcommand i" -l root -d 'Installation root' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand i" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand i" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand i" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand i" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand i" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand i" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand i" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand i" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand i" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand i" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand i" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand i" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand i" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand i" -s f -l force -d 'Forcefully overwrite existing installation'
complete -c deno -n "__fish_deno_using_subcommand i" -s g -l global -d 'Install a package or script as a globally available executable'
complete -c deno -n "__fish_deno_using_subcommand i" -s e -l entrypoint -d 'Install dependents of the specified entrypoint(s)'
complete -c deno -n "__fish_deno_using_subcommand i" -s D -l dev -d 'Add the package as a dev dependency. Note: This only applies when adding to a `package.json` file.'
complete -c deno -n "__fish_deno_using_subcommand i" -l npm -d 'assume unprefixed package names are npm packages'
complete -c deno -n "__fish_deno_using_subcommand i" -l jsr -d 'assume unprefixed package names are jsr packages'
complete -c deno -n "__fish_deno_using_subcommand json_reference" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand json_reference" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand json_reference" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -s n -l name -d 'Set a name for the kernel (defaults to \'deno\'). Useful when maintaing multiple Deno kernels.' -r
complete -c deno -n "__fish_deno_using_subcommand jupyter" -s d -l display -d 'Set a display name for the kernel (defaults to \'Deno\'). Useful when maintaing multiple Deno kernels.' -r
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l conn -d 'Path to JSON file describing connection parameters, provided by Jupyter' -r -F
complete -c deno -n "__fish_deno_using_subcommand jupyter" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand jupyter" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l install -d 'Install a kernelspec'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l force -d 'Force installation of a kernel, overwriting previously existing kernelspec'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -l kernel -d 'Start the kernel'
complete -c deno -n "__fish_deno_using_subcommand jupyter" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand uninstall" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l root -d 'Installation root' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -s g -l global -d 'Remove globally installed package or module'
complete -c deno -n "__fish_deno_using_subcommand uninstall" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand outdated" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand outdated" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand outdated" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand outdated" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand outdated" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l latest -d 'Consider the latest version, regardless of semver constraints'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l compatible -d 'Only consider versions that satisfy semver requirements'
complete -c deno -n "__fish_deno_using_subcommand outdated" -s r -l recursive -d 'Include all workspace members'
complete -c deno -n "__fish_deno_using_subcommand outdated" -s i -l interactive -d 'Interactively select which dependencies to update'
complete -c deno -n "__fish_deno_using_subcommand outdated" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand outdated" -s u -l update -d 'Update dependency versions'
complete -c deno -n "__fish_deno_using_subcommand lsp" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand lsp" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand lsp" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand lint" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand lint" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand lint" -l ext -d 'Specify the file extension to lint when reading from stdin.For example, use `jsx` to lint JSX files or `tsx` for TSX files.This argument is necessary because stdin input does not automatically infer the file type.Example usage: `cat file.jsx | deno lint - --ext=jsx`.' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -l rules-tags -d 'Use set of rules with a tag' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -l rules-include -d 'Include lint rules' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -l rules-exclude -d 'Exclude lint rules' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand lint" -l ignore -d 'Ignore linting particular source files' -r -F
complete -c deno -n "__fish_deno_using_subcommand lint" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand lint" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand lint" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand lint" -l fix -d 'Fix any linting errors for rules that support it'
complete -c deno -n "__fish_deno_using_subcommand lint" -l rules -d 'List available rules'
complete -c deno -n "__fish_deno_using_subcommand lint" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand lint" -l json -d 'Output lint result in JSON format'
complete -c deno -n "__fish_deno_using_subcommand lint" -l compact -d 'Output lint result in compact format'
complete -c deno -n "__fish_deno_using_subcommand lint" -l permit-no-files -d 'Don\'t return an error code if no files were found'
complete -c deno -n "__fish_deno_using_subcommand lint" -l watch -d 'Watch for file changes and restart process automatically.   Only local files from entry point module graph are watched.'
complete -c deno -n "__fish_deno_using_subcommand lint" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand publish" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand publish" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand publish" -l token -d 'The API token to use when publishing. If unset, interactive authentication is be used' -r
complete -c deno -n "__fish_deno_using_subcommand publish" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand publish" -l set-version -d 'Set version for a package to be published.   This flag can be used while publishing individual packages and cannot be used in a workspace.' -r
complete -c deno -n "__fish_deno_using_subcommand publish" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand publish" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand publish" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand publish" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand publish" -l dry-run -d 'Prepare the package for publishing performing all checks and validations without uploading'
complete -c deno -n "__fish_deno_using_subcommand publish" -l allow-slow-types -d 'Allow publishing with slow types'
complete -c deno -n "__fish_deno_using_subcommand publish" -l allow-dirty -d 'Allow publishing if the repository has uncommitted changed'
complete -c deno -n "__fish_deno_using_subcommand publish" -l no-provenance -d 'Disable provenance attestation.   Enabled by default on Github actions, publicly links the package to where it was built and published from.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand repl" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand repl" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand repl" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand repl" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand repl" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand repl" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand repl" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand repl" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l eval-file -d 'Evaluates the provided file(s) as scripts when the REPL starts. Accepts file paths and URLs' -r -F
complete -c deno -n "__fish_deno_using_subcommand repl" -l eval -d 'Evaluates the provided code when the REPL starts' -r
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand repl" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand repl" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand repl" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand repl" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand repl" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand repl" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand repl" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand repl" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand repl" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand repl" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand repl" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand repl" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand repl" -l json
complete -c deno -n "__fish_deno_using_subcommand task" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand task" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand task" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand task" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand task" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand task" -l cwd -d 'Specify the directory to run the task in' -r -f -a "(__fish_complete_directories)"
complete -c deno -n "__fish_deno_using_subcommand task" -s f -l filter -d 'Filter members of the workspace by name, implies --recursive flag' -r
complete -c deno -n "__fish_deno_using_subcommand task" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand task" -l connected -r
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand task" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand task" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand task" -s r -l recursive -d 'Run the task in all projects in the workspace'
complete -c deno -n "__fish_deno_using_subcommand task" -l eval -d 'Evaluate the passed value as if it was a task in a configuration file'
complete -c deno -n "__fish_deno_using_subcommand test" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -l no-check -d 'Skip type-checking. If the value of "remote" is supplied, diagnostic errors from remote modules will be ignored' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l import-map -d 'Load import map file from local file or remote URL   Docs: https://docs.deno.com/runtime/manual/basics/import_maps' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l node-modules-dir -d 'Sets the node modules management mode for npm packages' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l vendor -d 'Toggles local vendor folder usage for remote modules and a node_modules folder for npm packages' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -l conditions -d 'Use this argument to specify custom conditions for npm package exports. You can also use DENO_CONDITIONS env var.  Docs: https://docs.deno.com/go/conditional-exports' -r
complete -c deno -n "__fish_deno_using_subcommand test" -s c -l config -d 'Configure different aspects of deno including TypeScript, linting, and code formatting.   Typically the configuration file will be called `deno.json` or `deno.jsonc` and   automatically detected; in that case this flag is not necessary.   Docs: https://docs.deno.com/go/config' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -s r -l reload -d 'Reload source code cache (recompile TypeScript)   no value                                                 Reload everything   jsr:@std/http/file-server,jsr:@std/assert/assert-equals  Reloads specific modules   npm:                                                     Reload all npm modules   npm:chalk                                                Reload specific npm module' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l preload -d 'A list of files that will be executed before the main module' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -s P -l permission-set -r
complete -c deno -n "__fish_deno_using_subcommand test" -s R -l allow-read -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-read -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -s W -l allow-write -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-write -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -s N -l allow-net -r
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-net -r
complete -c deno -n "__fish_deno_using_subcommand test" -s E -l allow-env -r
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-env -r
complete -c deno -n "__fish_deno_using_subcommand test" -s S -l allow-sys -r
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-sys -r
complete -c deno -n "__fish_deno_using_subcommand test" -l allow-run -r
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-run -r
complete -c deno -n "__fish_deno_using_subcommand test" -l allow-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-ffi -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -s I -l allow-import -d 'Allow importing from remote hosts. Optionally specify allowed IP addresses and host names, with ports as necessary. Default value: deno.land:443,jsr.io:443,esm.sh:443,cdn.jsdelivr.net:443,raw.githubusercontent.com:443,user.githubusercontent.com:443' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-import -d 'Deny importing from remote hosts. Optionally specify denied IP addresses and host names, with ports as necessary.' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l inspect -d 'Activate inspector on host:port [default: 127.0.0.1:9229]' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l inspect-brk -d 'Activate inspector on host:port, wait for debugger to connect and break at the start of user script' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l inspect-wait -d 'Activate inspector on host:port and wait for debugger to connect before running user code' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l allow-scripts -d 'Allow running npm lifecycle scripts for the given packages   Note: Scripts will only be executed when using a node_modules directory (`--node-modules-dir`)' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l location -d 'Value of globalThis.location used by some web APIs' -r -f
complete -c deno -n "__fish_deno_using_subcommand test" -l v8-flags -d 'To see a list of all available flags use --v8-flags=--help   Flags can also be set via the DENO_V8_FLAGS environment variable.   Any flags set with this flag are appended after the DENO_V8_FLAGS environment variable' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l seed -d 'Set the random number generator seed' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l trace-ops -d 'Trace low-level op calls' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l check -d 'Set type-checking behavior. This subcommand type-checks local modules by default, so adding --check is redundant   If the value of "all" is supplied, remote modules will be included.   Alternatively, the \'deno check\' subcommand can be used' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l ignore -d 'Ignore files' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l fail-fast -d 'Stop after N errors. Defaults to stopping after first failure' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l filter -d 'Run tests with this string or regexp pattern in the test name' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l shuffle -d 'Shuffle the order in which the tests are run' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l coverage -d 'Collect coverage profile data into DIR. If DIR is not specified, it uses \'coverage/\'.   This option can also be set via the DENO_COVERAGE_DIR environment variable.' -r
complete -c deno -n "__fish_deno_using_subcommand test" -l watch -d 'Watch for file changes and restart process automatically.   Local files from entry point module graph are watched by default.   Additional paths might be watched by passing them as arguments to this flag.' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l watch-exclude -d 'Exclude provided files/patterns from watch mode' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l junit-path -d 'Write a JUnit XML test report to PATH. Use \'-\' to write to stdout which is the default when PATH is not provided' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l reporter -d 'Select reporter to use. Default to \'pretty\'' -r -f -a "pretty\t''
dot\t''
junit\t''
tap\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -l env-file -d 'Load environment variables from local file   Only the first environment variable with a given key is used.   Existing process environment variables are not overwritten, so if variables with the same names already exist in the environment, their values will be preserved.   Where multiple declarations for the same environment variable exist in your .env file, the first one encountered is applied. This is determined by the order of the files you pass as arguments.' -r -F
complete -c deno -n "__fish_deno_using_subcommand test" -l ext -d 'Set content type of the supplied file' -r -f -a "ts\t''
tsx\t''
js\t''
jsx\t''
mts\t''
mjs\t''
cts\t''
cjs\t''"
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand test" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand test" -l no-remote -d 'Do not resolve remote modules'
complete -c deno -n "__fish_deno_using_subcommand test" -l no-npm -d 'Do not resolve npm modules'
complete -c deno -n "__fish_deno_using_subcommand test" -l no-config -d 'Disable automatic loading of the configuration file'
complete -c deno -n "__fish_deno_using_subcommand test" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand test" -s A -l allow-all -d 'Allow all permissions'
complete -c deno -n "__fish_deno_using_subcommand test" -l allow-hrtime
complete -c deno -n "__fish_deno_using_subcommand test" -l deny-hrtime
complete -c deno -n "__fish_deno_using_subcommand test" -l no-prompt
complete -c deno -n "__fish_deno_using_subcommand test" -l cached-only -d 'Require that remote dependencies are already cached'
complete -c deno -n "__fish_deno_using_subcommand test" -l enable-testing-features-do-not-use -d 'INTERNAL: Enable internal features used during integration testing'
complete -c deno -n "__fish_deno_using_subcommand test" -l eszip-internal-do-not-use
complete -c deno -n "__fish_deno_using_subcommand test" -l no-run -d 'Cache test modules, but don\'t run tests'
complete -c deno -n "__fish_deno_using_subcommand test" -l trace-leaks -d 'Enable tracing of leaks. Useful when debugging leaking ops in test, but impacts test execution time'
complete -c deno -n "__fish_deno_using_subcommand test" -l doc -d 'Evaluate code blocks in JSDoc and Markdown'
complete -c deno -n "__fish_deno_using_subcommand test" -l permit-no-files -d 'Don\'t return an error code if no files were found'
complete -c deno -n "__fish_deno_using_subcommand test" -l coverage-raw-data-only -d 'Only collect raw coverage data, without generating a report'
complete -c deno -n "__fish_deno_using_subcommand test" -l clean -d 'Empty the temporary coverage profile data directory before running tests.   Note: running multiple `deno test --clean` calls in series or parallel for the same coverage directory may cause race conditions.'
complete -c deno -n "__fish_deno_using_subcommand test" -l parallel -d 'Run test modules in parallel. Parallelism defaults to the number of available CPUs or the value of the DENO_JOBS environment variable'
complete -c deno -n "__fish_deno_using_subcommand test" -l no-clear-screen -d 'Do not clear terminal screen when under watch mode'
complete -c deno -n "__fish_deno_using_subcommand test" -l hide-stacktraces -d 'Hide stack traces for errors in failure test results.'
complete -c deno -n "__fish_deno_using_subcommand types" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand types" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand types" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand update" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand update" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand update" -l lock -d 'Check the specified lock file. (If value is not provided, defaults to "./deno.lock")' -r -F
complete -c deno -n "__fish_deno_using_subcommand update" -l frozen -d 'Error out if lockfile is out of date' -r -f -a "true\t''
false\t''"
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand update" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand update" -l latest -d 'Consider the latest version, regardless of semver constraints'
complete -c deno -n "__fish_deno_using_subcommand update" -l compatible -d 'Only consider versions that satisfy semver requirements'
complete -c deno -n "__fish_deno_using_subcommand update" -s r -l recursive -d 'Include all workspace members'
complete -c deno -n "__fish_deno_using_subcommand update" -s i -l interactive -d 'Interactively select which dependencies to update'
complete -c deno -n "__fish_deno_using_subcommand update" -l no-lock -d 'Disable auto discovery of the lock file'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand upgrade" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l version -d 'The version to upgrade to' -r
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l output -d 'The path to output the updated version to' -r -F
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l cert -d 'Load certificate authority from PEM encoded file' -r -F
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unsafely-ignore-certificate-errors -d 'DANGER: Disables verification of TLS certificates' -r
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l dry-run -d 'Perform all checks without replacing old exe'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -s f -l force -d 'Replace current exe even if not out-of-date'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l canary -d 'Upgrade to canary builds'
complete -c deno -n "__fish_deno_using_subcommand upgrade" -l rc -d 'Upgrade to a release candidate'
complete -c deno -n "__fish_deno_using_subcommand vendor" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand vendor" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand vendor" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable -d 'The `--unstable` flag has been deprecated. Use granular `--unstable-*` flags instead   To view the list of individual unstable feature flags, run this command again with --help=unstable'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-bare-node-builtins -d 'Enable unstable bare node builtins feature'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-broadcast-channel -d 'Enable unstable `BroadcastChannel` API'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-bundle -d 'Enable unstable bundle runtime API'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-byonm -d ''
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-cron -d 'Enable unstable `Deno.cron` API'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-detect-cjs -d 'Treats ambiguous .js, .jsx, .ts, .tsx files as CommonJS modules in more cases'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-ffi -d 'Enable unstable FFI APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-fs -d 'Enable unstable file system APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-http -d 'Enable unstable HTTP APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-kv -d 'Enable unstable KV APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-lazy-dynamic-imports -d 'Lazily loads statically analyzable dynamic imports when not running with type checking. Warning: This may change the order of semver specifier resolution.'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-lockfile-v5 -d 'Enable unstable lockfile v5'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-net -d 'enable unstable net APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-no-legacy-abort -d 'Enable abort signal in Deno.serve without legacy behavior. This will not abort the server when the request is handled successfully.'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-node-globals -d 'Prefer Node.js globals over Deno globals - currently this refers to `setTimeout` and `setInterval` APIs.'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-npm-lazy-caching -d 'Enable unstable lazy caching of npm dependencies, downloading them only as needed (disabled: all npm packages in package.json are installed on startup; enabled: only npm packages that are actually referenced in an import are installed'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-otel -d 'Enable unstable OpenTelemetry features'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-process -d 'Enable unstable process APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-raw-imports -d 'Enable unstable \'bytes\' and \'text\' imports.'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-sloppy-imports -d 'Enable unstable resolving of specifiers by extension probing, .js to .ts, and directory probing'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-subdomain-wildcards -d 'Enable subdomain wildcards support for the `--allow-net` flag'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-temporal -d 'Enable unstable Temporal API'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-unsafe-proto -d 'Enable unsafe __proto__ support. This is a security risk.'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-vsock -d 'Enable unstable VSOCK APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-webgpu -d 'Enable unstable WebGPU APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -l unstable-worker-options -d 'Enable unstable Web Worker APIs'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "run"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "serve"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "add"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "remove"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "bench"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "bundle"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "cache"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "check"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "clean"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "compile"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "completions"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "coverage"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "doc"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "deploy"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "eval"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "fmt"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "init"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "info"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "install"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "json_reference"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "jupyter"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "uninstall"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "outdated"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "lsp"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "lint"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "publish"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "repl"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "task"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "test"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "types"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "update"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "upgrade"
complete -c deno -n "__fish_deno_using_subcommand help; and not __fish_seen_subcommand_from run serve add remove bench bundle cache check clean compile completions coverage doc deploy eval fmt init info install json_reference jupyter uninstall outdated lsp lint publish repl task test types update upgrade vendor" -f -a "vendor"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from run" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from run" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from run" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from serve" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from serve" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from serve" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from add" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from add" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from add" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from remove" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from remove" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from remove" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bench" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bench" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bench" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bundle" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bundle" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from bundle" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from cache" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from cache" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from cache" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from check" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from check" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from check" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from clean" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from clean" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from clean" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from compile" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from compile" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from compile" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from completions" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from completions" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from completions" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from coverage" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from coverage" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from coverage" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from doc" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from doc" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from doc" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from deploy" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from deploy" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from deploy" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from eval" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from eval" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from eval" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from fmt" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from fmt" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from fmt" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from init" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from init" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from init" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from info" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from info" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from info" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from install" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from install" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from install" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from json_reference" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from json_reference" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from json_reference" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from jupyter" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from jupyter" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from jupyter" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from uninstall" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from uninstall" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from uninstall" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from outdated" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from outdated" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from outdated" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lsp" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lsp" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lsp" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lint" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lint" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from lint" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from publish" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from publish" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from publish" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from repl" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from repl" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from repl" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from task" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from task" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from task" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from test" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from test" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from test" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from types" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from types" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from types" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from update" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from update" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from upgrade" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from upgrade" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from upgrade" -s q -l quiet -d 'Suppress diagnostic output'
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from vendor" -s h -l help -r -f -a "unstable\t''
full\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from vendor" -s L -l log-level -d 'Set log level' -r -f -a "trace\t''
debug\t''
info\t''"
complete -c deno -n "__fish_deno_using_subcommand help; and __fish_seen_subcommand_from vendor" -s q -l quiet -d 'Suppress diagnostic output'

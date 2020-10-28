# Parse languages
cd source || exit 1
LANGUAGES="en de-DE"
cd .. || exit 1
NUM_LANGUAGES="$(printf '%s' "$LANGUAGES" | wc -w)"

i=1
for lang in $LANGUAGES
do
    printf -- '----- Building language "%s"... [%d/%d] -----\n' "$lang" "$i" "$NUM_LANGUAGES"
    make latexpdf SPHINXOPTS="-Q -j $(nproc) -Dlanguage=$lang" >/dev/null
    i=$((i + 1))
done

cd build/latex || exit 1
mkdir -p ../pdf
for file in */*/Mixxx-Manual.pdf
do
    newfilename="mixxx-manual-$(dirname "$file" | tr "/" "-")"
    cp "$file" "../pdf/${newfilename}.pdf"
done
find ../pdf -type f

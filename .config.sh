TKPORT_TMPL_REPOSITORY=$1
TKPORT_TMPL_NAME="$(basename ${TKPORT_TMPL_REPOSITORY})"
TKPORT_TMPL_ACTOR=$2
TKPORT_TMPL_README="README"

# Instead

instead() {
  local tmpl=$1
  local trgt=$2
  local path=$3
  local subpath=$4

  local tmpl_path="${path}${subpath:+/}${subpath}"
  local trgt_path="${path}${subpath:+/}${subpath//${tmpl}/${trgt}}"

  if [ -d "${tmpl_path}" ];then
    for subpath in $(ls "${tmpl_path}"); do
      instead "${tmpl}" "${trgt}" "${tmpl_path}" "${subpath}"
    done
  fi
  if [ -f "${tmpl_path}" ];then
    sed -i "" "s,${tmpl},${trgt},g" "${tmpl_path}"
  fi
  if [[ "${tmpl_path}" =~ "${tmpl}" ]];then
    mv "${tmpl_path}" "${trgt_path}"
  fi
}
instead "TKPORT_TMPL_REPOSITORY" "${TKPORT_TMPL_REPOSITORY}" .
instead "TKPORT_TMPL_NAME" "${TKPORT_TMPL_NAME}" .
instead "TKPORT_TMPL_ACTOR" "${TKPORT_TMPL_ACTOR}" .
instead "TKPORT_TMPL_README" "${TKPORT_TMPL_README}" .

# Instead workflows

rm -fr .github/workflows
mv workflows .github/workflows

# Commit
git add .
git rm --cached .config.sh 
git commit -m "Config ${TKPORT_TMPL_REPOSITORY} by ${TKPORT_TMPL_ACTOR}"

# reset remote-origin
if [ $(git remote | grep origin) ];then
  git remote remove origin
fi
git remote add origin git@github.com:${TKPORT_TMPL_REPOSITORY}.git

# Delete .config.sh 
rm .config.sh 
# 模板分支
master

# 模板配置执行
.github/workflows/auto-config.yml

# 模版替换
TKPORT_TMPL_REPOSITORY -> ${GITHUB_REPOSITORY}
TKPORT_TMPL_NAME -> $(basename ${GITHUB_REPOSITORY})
TKPORT_TMPL_ACTOR -> ${GITHUB_ACTOR}
TKPORT_TMPL_README -> README
./workflows -> ./.github/workflows

# 模板移除
.config.sh
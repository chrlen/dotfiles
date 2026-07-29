# Public shell functions — available on all machines.

direxists() {
  [ -d "$1" ]
}

gpa (){
	COMMIT_MESSAGE=${1}
	git add -A && git commit -m ${COMMIT_MESSAGE} && git push
}

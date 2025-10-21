list=$(config list)

echo "list: $list"
echo "===================="

for m in $list; do
  rm -rf log.txt
  if zef install $m 1>log.txt 2>&1; then
    echo "module $m installation succeed"
  else
    echo "module $m installation failed"
    echo "log"
    echo "==="
    cat log.txt
  fi
  echo "==="
done

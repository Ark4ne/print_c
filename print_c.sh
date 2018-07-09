# Usage : print_c msg [ arg1 [ arg2 [ ... ]]]
#
# print_c "<{color};{modifier};{bgcolor}>msg</{...}>"
# print_c "<red>test</red>"
# print_c "<red;under>test</red>"
# print_c "<red;under;white>test</red>"
# print_c "\n<cyan>%d</cyan> => <red;under>%d</red>:<purple;;white>%d</green>\n" 11 22 33

print_c(){
  local C_BLACK="0"
  local C_RED="1"
  local C_GREEN="2"
  local C_YELLOW="3"
  local C_BLUE="4"
  local C_PURPLE="5"
  local C_CYAN="6"
  local C_WHITE="7"

  local r="<([a-z]+)(;([a-z]*))?(;([a-z]*))?>([^<]+)</([a-z;]*)>"

  local str="$1"

  while [[ "$str" =~ $r ]]; do

    local rt=""
    local rs=""
    local UNDER=""
    local BOLD=""
    local HIGH=""
    local COLOR=""
    local BGCOLOR=""
    local WEIGHT=0

    case ${BASH_REMATCH[1]} in
      black)   COLOR=$C_BLACK  ;;
      red)     COLOR=$C_RED    ;;
      green)   COLOR=$C_GREEN  ;;
      yellow)  COLOR=$C_YELLOW ;;
      blue)    COLOR=$C_BLUE   ;;
      purple)  COLOR=$C_PURPLE ;;
      cyan)    COLOR=$C_CYAN   ;;
      white)   COLOR=$C_WHITE  ;;
    esac

    if [ ! -z "${BASH_REMATCH[3]}" ]; then
      case ${BASH_REMATCH[3]} in
        bold)  BOLD=1      ;;
        high)  HIGH=1      ;;
        under) UNDER=1     ;;
      esac
    fi

    if [ ! -z "${BASH_REMATCH[5]}" ]; then
      case ${BASH_REMATCH[5]} in
        black)   BGCOLOR=$C_BLACK  ;;
        red)     BGCOLOR=$C_RED    ;;
        green)   BGCOLOR=$C_GREEN  ;;
        yellow)  BGCOLOR=$C_YELLOW ;;
        blue)    BGCOLOR=$C_BLUE   ;;
        purple)  BGCOLOR=$C_PURPLE ;;
        cyan)    BGCOLOR=$C_CYAN   ;;
        white)   BGCOLOR=$C_WHITE  ;;
      esac

      BGCOLOR="4$BGCOLOR"
    fi

    if [ $BOLD ]; then
      WEIGHT=1
    fi
    if [ $UNDER ]; then
      WEIGHT=4
    fi
    if [ $HIGH ]; then
        COLOR="9$COLOR"
    else
      COLOR="3$COLOR"
    fi

    rt="<${BASH_REMATCH[1]}${BASH_REMATCH[2]}${BASH_REMATCH[4]}>${BASH_REMATCH[6]}</${BASH_REMATCH[7]}>"

    if [ -z "$COLOR" ]; then
      rs=${BASH_REMATCH[6]}
    elif [ -z "$BGCOLOR" ]; then
      rs="\033[$WEIGHT;${COLOR}m${BASH_REMATCH[6]}\033[0m"
    else
      rs="\033[$WEIGHT;${COLOR};${BGCOLOR}m${BASH_REMATCH[6]}\033[0m"
    fi

    str=${str//"$rt"/"$rs"}
  done

  printf "$str" "${@:2}"
}

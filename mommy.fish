function _mommy_postexec_hook --on-event fish_postexec
    set -l last_status $status

    if test -z "$argv[1]"
        return
    end

    set -l color_pink '\033[38;5;217m'
    set -l color_blue '\033[38;5;117m'
    set -l color_faint '\033[2m'
    set -l color_reset '\033[0m'

    set -l words_little "boy"
    if set -q SHELL_MOMMYS_LITTLE; set words_little $SHELL_MOMMYS_LITTLE; end

    set -l words_pronouns "her"
    if set -q SHELL_MOMMYS_PRONOUNS; set words_pronouns $SHELL_MOMMYS_PRONOUNS; end

    set -l words_roles "mommy"
    if set -q SHELL_MOMMYS_ROLES; set words_roles $SHELL_MOMMYS_ROLES; end

    set -l mommy_color $color_pink
    if set -q SHELL_MOMMYS_COLOR; set mommy_color $SHELL_MOMMYS_COLOR; end

    set -l only_negative "false"
    if test "$SHELL_MOMMYS_ONLY_NEGATIVE" = "true"; set only_negative "true"; end

    set -l positive_responses \
        "*pets your head*" \
        "awe, what a good AFFECTIONATE_TERM~\nMOMMYS_ROLE knew you could do it~ <3" \
        "good AFFECTIONATE_TERM~\nMOMMYS_ROLE's so proud of you~ <3" \
        "Keep up the good work, my love~ <3" \
        "MOMMYS_ROLE is proud of the progress you've made~ <3" \
        "MOMMYS_ROLE is so grateful to have you as MOMMYS_PRONOUN little AFFECTIONATE_TERM~ <3" \
        "I'm so proud of you, my love~ <3" \
        "MOMMYS_ROLE is so proud of you~ <3" \
        "MOMMYS_ROLE loves seeing MOMMYS_PRONOUN little AFFECTIONATE_TERM succeed~ <3" \
        "MOMMYS_ROLE thinks MOMMYS_PRONOUN little AFFECTIONATE_TERM earned a big hug~ <3" \
        "that's a good AFFECTIONATE_TERM~ <3" \
        "you did an amazing job, my dear~ <3" \
        "you're such a smart cookie~ <3"

    set -l negative_responses \
        "do you need MOMMYS_ROLE's help~? <3" \
        "Don't give up, my love~ <3" \
        "Don't worry, MOMMYS_ROLE is here to help you~ <3" \
        "I believe in you, my sweet AFFECTIONATE_TERM~ <3" \
        "It's okay to make mistakes, my dear~ <3" \
        "just a little further, sweetie~ <3" \
        "Let's try again together, okay~? <3" \
        "MOMMYS_ROLE believes in you, and knows you can overcome this~ <3" \
        "MOMMYS_ROLE believes in you~ <3" \
        "MOMMYS_ROLE is always here for you, no matter what~ <3" \
        "MOMMYS_ROLE is here to help you through it~ <3" \
        "MOMMYS_ROLE is proud of you for trying, no matter what the outcome~ <3" \
        "MOMMYS_ROLE knows it's tough, but you can do it~ <3" \
        "MOMMYS_ROLE knows MOMMYS_PRONOUN little AFFECTIONATE_TERM can do better~ <3" \
        "MOMMYS_ROLE knows you can do it, even if it's tough~ <3" \
        "MOMMYS_ROLE knows you're feeling down, but you'll get through it~ <3" \
        "MOMMYS_ROLE knows you're trying your best~ <3" \
        "MOMMYS_ROLE loves you, and is here to support you~ <3" \
        "MOMMYS_ROLE still loves you no matter what~ <3" \
        "You're doing your best, and that's all that matters to MOMMYS_ROLE~ <3" \
        "MOMMYS_ROLE is always here to encourage you~ <3"

    if set -q SHELL_MOMMYS_POSITIVE_RESPONSES; set positive_responses $SHELL_MOMMYS_POSITIVE_RESPONSES; end
    if set -q SHELL_MOMMYS_NEGATIVE_RESPONSES; set negative_responses $SHELL_MOMMYS_NEGATIVE_RESPONSES; end

    set -l template ""

    if test $last_status -eq 0
        if test "$only_negative" = "true"
            return
        end
        set template (random choice $positive_responses)
    else
        set template (random choice $negative_responses)
    end

    set -l term_little (random choice (string split "/" $words_little))
    set -l term_pronoun (random choice (string split "/" $words_pronouns))
    set -l term_role (random choice (string split "/" $words_roles))

    set -l final_msg $template
    set final_msg (string replace -a "AFFECTIONATE_TERM" $term_little "$final_msg")
    set final_msg (string replace -a "MOMMYS_PRONOUN" $term_pronoun "$final_msg")
    set final_msg (string replace -a "MOMMYS_ROLE" $term_role "$final_msg")

    echo -e "$mommy_color$final_msg$color_reset"
end

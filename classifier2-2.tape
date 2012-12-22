global {
    evaldata=(DevOrTest: test dev)
}

task learn < in=train > model {
    ../../learner $in > $model
}

task predict < in=$evaldata model=$model@learn > preds {
    ../../predictor $model < $in > $preds
}

task eval < gold=$evaldata preds=@predict > scores :: T=(Threshold: 0.5 0.75) {
    cut -f2 $gold > temp
    paste temp $preds > gold_and_pred
    rm temp
    ../../evaluator $T gold_and_pred > $scores
}

plan CrossProduct {
    reach eval via (DevOrTest: *) * (Threshold: *)
}

plan Tuning {
    reach eval via (DevOrTest: dev) * (Threshold: *)
}

plan LearnOnly {
    reach learn
}

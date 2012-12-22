task learn < in=train > model {
    ../../learner $in > $model
}

task predict < in=test model=$model@learn > preds {
    ../../predictor $model < $in > $preds
}

task eval < gold=test preds=@predict > scores {
    cut -f2 $gold > temp
    paste temp $preds > gold_and_pred
    rm temp
    ../../evaluator gold_and_pred > $scores
}

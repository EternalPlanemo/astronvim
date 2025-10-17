<?php

use Illuminate\Contracts\View\View as ViewContract;
use Illuminate\Contracts\View\Factory as ViewFactory;
use Illuminate\View\View;

/**
 * Get the evaluated view contents for the given view.
 *
 * @param  string|null  $view
 * @param  array  $data
 * @param  array  $mergeData
 * @return \Illuminate\View\View|\Illuminate\Contracts\View\View
 */
function view(?string $view = null, array $data = [], array $mergeData = []): View {}

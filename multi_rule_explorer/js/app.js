(function() {

  $(function() {
    var applySelection, editorElement, inlineClosed, listElementPadding, modifySelectionSize, navTopPadding, nudgeSelection, openHeight, ruleClosed, ruleContainerElement, ruleElements, ruleNavListElements, ruleVerticalShift, selectionElement, selectionIndicatorHeight, selectionIndicatorShift, selectionSize, selectionStart;
    openHeight = 0;
    ruleVerticalShift = 0;
    ruleElements = $('.inline.editor .rule');
    ruleContainerElement = $('.rulesContainer')[0];
    editorElement = $('.inline.editor')[0];
    selectionStart = 0;
    selectionSize = Math.min(3, ruleElements.length);
    inlineClosed = true;
    ruleClosed = true;
    selectionIndicatorHeight = 0;
    selectionIndicatorShift = 0;
    selectionElement = $('.selection')[0];
    ruleNavListElements = $('.related li');
    navTopPadding = 12;
    listElementPadding = 0;
    modifySelectionSize = function(amount) {
      if (selectionSize + amount <= ruleElements.length && selectionSize + amount > 0) {
        selectionSize += amount;
        return applySelection();
      }
    };
    nudgeSelection = function(amount) {
      if (selectionStart + amount < ruleElements.length && selectionStart + amount >= 0) {
        selectionStart += amount;
        return applySelection();
      }
    };
    applySelection = function() {
      var displayedRules, listElement, newOpenHeight, newSelectionIndicatorHeight, newSelectionIndicatorShift, newVerticalShift, rule, selectedListElements, topHiddenRules, topListElements, _i, _j, _k, _l, _len, _len2, _len3, _len4;
      displayedRules = ruleElements.slice(selectionStart, selectionStart + selectionSize);
      topHiddenRules = ruleElements.slice(0, selectionStart);
      newVerticalShift = 0;
      for (_i = 0, _len = topHiddenRules.length; _i < _len; _i++) {
        rule = topHiddenRules[_i];
        newVerticalShift += $(rule).outerHeight();
      }
      if (newVerticalShift !== ruleVerticalShift) {
        ruleVerticalShift = newVerticalShift;
        $(ruleContainerElement).css('top', -1 * ruleVerticalShift);
      }
      newOpenHeight = 0;
      for (_j = 0, _len2 = displayedRules.length; _j < _len2; _j++) {
        rule = displayedRules[_j];
        newOpenHeight += $(rule).outerHeight();
      }
      if (openHeight !== newOpenHeight) {
        openHeight = newOpenHeight;
        if (!inlineClosed) $(editorElement).height(openHeight);
      }
      newSelectionIndicatorHeight = 0;
      newSelectionIndicatorShift = 0;
      selectedListElements = ruleNavListElements.slice(selectionStart, selectionStart + selectionSize);
      topListElements = ruleNavListElements.slice(0, selectionStart);
      for (_k = 0, _len3 = topListElements.length; _k < _len3; _k++) {
        listElement = topListElements[_k];
        newSelectionIndicatorShift += $(listElement).outerHeight() + listElementPadding;
        console.log($(listElement).outerHeight());
      }
      for (_l = 0, _len4 = selectedListElements.length; _l < _len4; _l++) {
        listElement = selectedListElements[_l];
        newSelectionIndicatorHeight += $(listElement).outerHeight() + listElementPadding;
      }
      if (selectionIndicatorHeight !== newSelectionIndicatorHeight) {
        selectionIndicatorHeight = newSelectionIndicatorHeight;
      }
      if (selectionIndicatorShift !== newSelectionIndicatorShift) {
        selectionIndicatorShift = newSelectionIndicatorShift;
      }
      $(selectionElement).height(selectionIndicatorHeight);
      $(selectionElement).css('top', selectionIndicatorShift + navTopPadding);
      return console.log('Start: ' + selectionStart + '; SelectionSize: ' + selectionSize + ';');
    };
    applySelection();
    return $(document).keydown(function(event) {
      var height, width;
      switch (event.keyCode) {
        case 38:
          if (!inlineClosed) nudgeSelection(-1);
          return event.preventDefault();
        case 40:
          if (!inlineClosed) nudgeSelection(1);
          return event.preventDefault();
        case 67:
          if (!inlineClosed) {
            width = 0;
            if (ruleClosed) {
              $('.relatedContainer > *').each(function(index) {
                return width += $(this).outerWidth();
              });
            }
            $('.relatedContainer').width(width + 1);
            return ruleClosed = !ruleClosed;
          }
          break;
        case 69:
          height = 0;
          if (inlineClosed) height = openHeight;
          $('.inline.editor').height(height);
          return inlineClosed = !inlineClosed;
        case 187:
          return modifySelectionSize(1);
        case 189:
          return modifySelectionSize(-1);
      }
    });
  });

}).call(this);

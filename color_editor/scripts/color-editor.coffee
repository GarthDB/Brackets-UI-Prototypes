define ['helper/colors'], (colors) ->
	class ColorEditor

		constructor: (@element, color) ->
			@satLumBlock = $(@element).children('.saturation-luminosity-block')[0]
			@hueSlider = $(@element).children('.hue-slider')[0]
			@opacitySlider = $(@element).children('.opacity-slider')[0]
			@colorIndicator = $(@element).children('.color-indicator')[0]
			@originalColorIndicator = $(@colorIndicator).children('.original-color')[0]
			@buttonBar = $(@element).children('.button-bar')[0]

			@parseColor color
			@originalColor = color
			$(@satLumBlock).mousedown @satLumMousedownHandler
			$(@hueSlider).mousedown @hueMousedownHandler
			$(@opacitySlider).mousedown @opacityMousedownHandler

			$(@buttonBar).children('li').click @buttonbarButtonClickHandler

			$(@originalColorIndicator).css({background: @originalColor})
			$(@originalColorIndicator).click =>
				@parseColor @originalColor
		parseColor: (color) ->
			if color.match(/^#?([a-f0-9]{6}|[a-f0-9]{3})$/i)
				if color.match(/^#?[a-f0-9]{3}$/i)
					color = color.replace('#','')
					colorAr = color.split('')
					color = colorAr[0]+colorAr[0]+colorAr[1]+colorAr[1]+colorAr[2]+colorAr[2]
				@color = Colors.ColorFromHex(color)
			else if color.match(/^hsla?\((\d|,|%| |.)*\)$/i)
				color = color.substring(color.indexOf('(')+1,color.indexOf(')'))
				color = color.replace(/( )/g,'')
				colorAr = color.split(',')
				adjustedColorAr = (@parsePercentage colorItem for colorItem in colorAr)
				@color = Colors.ColorFromHSV adjustedColorAr[0],adjustedColorAr[1],adjustedColorAr[2]
			else if color.match(/^rgba?\((\d|,|%| |.)*\)$/i)
				color = color.substring(color.indexOf('(')+1,color.indexOf(')'))
				color = color.replace(/( )/g,'')
				colorAr = color.split(',')
				adjustedColorAr = (@parsePercentage colorItem for colorItem in colorAr)
				@color = Colors.ColorFromRGB adjustedColorAr[0],adjustedColorAr[1],adjustedColorAr[2]
			@updateColor()
		parsePercentage: (valueString) ->
			output
			if valueString.indexOf('%') != -1
				valueString = valueString.replace('%','')
				output = parseFloat(valueString)/100
			else
				output = parseFloat(valueString)
			return output
		updateColor: () ->
			$(@element).children('.saturation-luminosity-block').css('background', 'hsl('+@color.Hue()+', 100%, 50%)')
			transparent = 'rgba('+@color.Red()+','+@color.Green()+','+@color.Blue()+',0)'
			$(@element).children('.opacity-slider').children('.opacity-gradient').css({background: "-webkit-linear-gradient(top, "+@color.HexString()+", "+transparent+")"})
			$(@element).children('.saturation-luminosity-block').children('.selector').css({left: String(@color.Saturation()*100)+'%', bottom: String(@color.Value()*100)+'%'})
			$(@element).children('.hue-slider').children('.selector').css({bottom: String((@color.Hue()/360) * 100)+'%'})
			$(@element).children('.opacity-slider').children('.selector').css({bottom: String(@color.Alpha() * 100)+'%'})
			$(@element).children('.color-indicator').children('.selected-color').css({background: 'rgba('+@color.Red()+','+@color.Green()+','+@color.Blue()+','+@color.Alpha()+')'})
			$('.colorLabel').html("hsla(#{Math.round(@color.Hue())}, #{Math.round(@color.Saturation()*100)}%, #{Math.round(@color.Value()*100)}%, #{Math.round(@color.Alpha() * 100)/100})")
		satLumMousedownHandler: (e) =>
			@color.SetHSV( @color.Hue(), e.offsetX/150, 1 - (e.offsetY/150))
			@updateColor()
			$(document).bind 'mouseup', @satLumMouseupHandler
			$(document).bind 'mousemove', @satLumMousemoveHandler
		satLumMousemoveHandler: (e) =>
			x = e.originalEvent.clientX - $(@satLumBlock).offset().left
			y = e.originalEvent.clientY - $(@satLumBlock).offset().top
			width = $(@satLumBlock).width()
			height = $(@satLumBlock).height()
			x = if (x >= width) then width else if (x < 0) then 0 else x
			y = if (y >= height) then height else if (y < 0) then 0 else y
			@color.SetHSV( @color.Hue(), x/150, 1 - (y/150))
			@updateColor()
		satLumMouseupHandler: (e) =>
			$(document).unbind 'mouseup', @satLumMouseupHandler
			$(document).unbind 'mousemove', @satLumMousemoveHandler
		
		hueMousedownHandler: (e) =>
			@color.SetHSV( (1 - e.offsetY/150) * 360, @color.Saturation(), @color.Value() )
			@updateColor()
			$(document).bind 'mouseup', @hueMouseupHandler
			$(document).bind 'mousemove', @hueMousemoveHandler
		hueMousemoveHandler: (e) =>
			y = e.originalEvent.clientY - $(@hueSlider).offset().top
			height = $(@hueSlider).height()
			y = if (y >= height) then height else if (y < 0) then 0 else y
			@color.SetHSV( (1 - y/height) * 360, @color.Saturation(), @color.Value() )
			@updateColor()
		hueMouseupHandler: (e) =>
			$(document).unbind 'mouseup', @hueMouseupHandler
			$(document).unbind 'mousemove', @hueMousemoveHandler
		
		opacityMousedownHandler: (e) =>
			@color.SetHSVA( @color.Hue(), @color.Saturation(), @color.Value(), (1 - e.offsetY/150) )
			@updateColor()
			$(document).bind 'mouseup', @opacityMouseupHandler
			$(document).bind 'mousemove', @opacityMousemoveHandler
		opacityMousemoveHandler: (e) =>
			y = e.originalEvent.clientY - $(@opacitySlider).offset().top
			height = $(@opacitySlider).height()
			y = if (y >= height) then height else if (y < 0) then 0 else y
			@color.SetHSVA( @color.Hue(), @color.Saturation(), @color.Value(), (1 - y/height) )
			@updateColor()
		opacityMouseupHandler: (e) =>
			$(document).unbind 'mouseup', @opacityMouseupHandler
			$(document).unbind 'mousemove', @opacityMousemoveHandler

		buttonbarButtonClickHandler: (e) =>
			console.log $(@buttonBar).children()




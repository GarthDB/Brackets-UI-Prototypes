define ['helper/colors'], (colors) ->
	class ColorEditor
		constructor: (@element, color) ->
			@parseColor color
			$(@element).children('.saturation-luminosity-block').click @satLumClickHandler
			$(@element).children('.hue-slider').click @hueClickHandler
			$(@element).children('.opacity-group').click @opacityClickHandler
			$(@element).children('.saturation-luminosity-block').bind 'drag', @satLumDragHandler
			$(@element).children('.saturation-luminosity-block').bind 'dragstart', @satLumDragstartHandler
			$(@element).children('.saturation-luminosity-block').bind 'drop', @satLumDropHandler
			$(@element).children('.saturation-luminosity-block').bind 'dragend', @satLumDragendHandler
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
			$(@element).children('.opacity-group').children('.opacity-slider').css({background: "-webkit-linear-gradient(top, "+@color.HexString()+", "+transparent+")"})
			$(@element).children('.saturation-luminosity-block').children('.selector').css({left: String(@color.Saturation()*100)+'%', bottom: String(@color.Value()*100)+'%'})
			$(@element).children('.hue-slider').children('.selector').css({bottom: String((@color.Hue()/360) * 100)+'%'})
			$(@element).children('.opacity-group').children('.selector').css({bottom: String(@color.Alpha() * 100)+'%'})
			$(@element).children('.color-indicator').children('.selected-color').css({background: 'rgba('+@color.Red()+','+@color.Green()+','+@color.Blue()+','+@color.Alpha()+')'})
		satLumClickHandler: (e) =>
			@color.SetHSV( @color.Hue(), e.offsetX/150, 1 - (e.offsetY/150))
			@updateColor()
		hueClickHandler: (e) =>
			@color.SetHSV( (1 - e.offsetY/150) * 360, @color.Saturation(), @color.Value() )
			@updateColor()
		opacityClickHandler: (e) =>
			@color.SetHSVA( @color.Hue(), @color.Saturation(), @color.Value(), (1 - e.offsetY/150) )
			@updateColor()
		satLumDragHandler: (e) =>
			y = if (e.originalEvent.offsetY >= 150) then 150 else if (e.originalEvent.offsetY < 0) then 0 else e.originalEvent.offsetY
			x = if (e.originalEvent.offsetX >= 150) then 150 else if (e.originalEvent.offsetX < 0) then 0 else e.originalEvent.offsetX
			# x = e.originalEvent.offsetX
			# y = (y >= 150) ? 150 : (y < 0) ? 0 : y
			# console.log y + ' = ' + x
			# console.log e
			@color.SetHSV( @color.Hue(), x/150, 1 - (y/150))
			@updateColor()
		satLumDropHandler: (e) =>
			console.log e
			if e.stopPropagation
				e.stopPropagation()
		satLumDragendHandler: (e) =>
			# console.log e.originalEvent.offsetY
			# console.log e.originalEvent.offsetX
		satLumDragstartHandler: (e) =>
			# e.target.style.opacity = '1.0'
			dragIcon = document.createElement('img')
			dragIcon.src = '/img/transparent_bg.svg'
			console.log $(dragIcon).css({display: 'none'})
			e.originalEvent.dataTransfer.setDragImage(dragIcon, -10, -10)
			console.log e.originalEvent.dataTransfer
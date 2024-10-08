#requires -Module PSSVG

$AssetsPath = $PSScriptRoot | Split-Path | Join-Path -ChildPath "Assets"

if (-not (Test-Path $AssetsPath)) {
    New-Item -ItemType Directory -Path $AssetsPath | Out-Null
}

$fontName = 'Anta'
$fontName = 'Heebo'
$fontName = 'Noto Sans'
$strokeWidth = '0.5%'
foreach ($variant in '','Animated') { 
    $outputPath = if (-not $variant) {
        Join-Path $assetsPath "PowerShellWeb.svg"
    } else {
        Join-Path $assetsPath "PowerShellWeb-$variant.svg"
    }
    svg -content $(
        $fillParameters = [Ordered]@{
            Fill        = '#4488FF'
            Class       = 'foreground-fill'        
        }
    
        $strokeParameters = [Ordered]@{
            Stroke      = '#4488FF'
            Class       = 'foreground-stroke'
            StrokeWidth = $strokeWidth
        }
    
        $transparentFill = [Ordered]@{Fill='transparent'}
        $animationDuration = [Ordered]@{
            Dur = "4.2s"
            RepeatCount = "indefinite"
        }
    
        SVG.GoogleFont -FontName $fontName
    
        svg.symbol -Id psChevron -Content @(
            svg.polygon -Points (@(
                "40,20"
                "45,20"
                "60,50"
                "35,80"
                "32.5,80"
                "55,50"
            ) -join ' ')
        ) -ViewBox 100, 100
    
        
    
        SVG.circle -CX 50% -Cy 50% -R 42% @transparentFill @strokeParameters -Content @(            
        )
        SVG.ellipse -Cx 50% -Cy 50% -Rx 23% -Ry 42% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '23%;16%;23%' -AttributeName rx @animationDuration
            }
        )
        SVG.ellipse -Cx 50% -Cy 50% -Rx 16% -Ry 42% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '16%;23%;16%' -AttributeName rx @animationDuration
            }
        ) -Opacity .9
        SVG.ellipse -Cx 50% -Cy 50% -Rx 15% -Ry 42% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '15%;16%;15%' -AttributeName rx @animationDuration                
            }
        ) -Opacity .8
        SVG.ellipse -Cx 50% -Cy 50% -Rx 42% -Ry 23% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '23%;16%;23%' -AttributeName ry @animationDuration
            }
        )
        SVG.ellipse -Cx 50% -Cy 50% -Rx 42% -Ry 16% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '16%;23%;16%' -AttributeName ry @animationDuration
            }
        ) -Opacity .9
        SVG.ellipse -Cx 50% -Cy 50% -Rx 42% -Ry 15% @transparentFill @strokeParameters  -Content @(
            if ($variant -match 'animate') {
                svg.animate -Values '15%;16%;15%' -AttributeName ry @animationDuration
            }
        ) -Opacity .8
        
        svg.use -Href '#psChevron' -Y 29% @fillParameters -Height 42%
    ) -ViewBox 0, 0, 200, 200 -OutputPath $outputPath
}

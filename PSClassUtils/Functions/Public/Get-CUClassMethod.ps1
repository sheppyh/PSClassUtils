Function Get-CuClassMethod {
    <#
    .SYNOPSIS
        Short description
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [cmdletBinding()]
    Param(
        [Parameter(Mandatory=$False, ValueFromPipeline=$False)]
        [String[]]$ClassName,

        [Parameter(ValueFromPipeline=$True)]
        [ValidateScript({
            If ( !($_.GetType().Name -eq "CUClass" ) ) { Throw "InputObect Must be of type CUClass.."} Else { $True }
        })]
        [Object[]]$InputObject
    )

    BEGIN {}

    PROCESS {

        If ( $MyInvocation.PipelinePosition -eq 1 ) {
            ## Not from the Pipeline
            If ( $Null -eq $PSBoundParameters['InputObject'] ) {
                Throw "Please Specify an InputObject of type CUClass"
            }
            If ( $Null -eq $PSBoundParameters['ClassName'] ) {
                $InputObject.GetCuClassMethod()
            } Else {
                Foreach ( $C in $ClassName ){
                    ($InputObject | where Name -eq $c).GetCuClassMethod()
                }
            }

        } Else {
            ## From the Pipeline
            If ( $Null -eq $PSBoundParameters['ClassName'] ) {
                #$InputObject.Name
                $InputObject.GetCuClassMethod()
                #"{0} - {1}" -f $InputObject.name,$($null -eq $InputObject.Method)
                #$InputObject.Method
                
            } Else {
                Throw "-ClassName parameter must be specified on the left side of the pipeline"
            }
        }

    }

    END {}

}
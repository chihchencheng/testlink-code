{* TestLink Open Source Project - http://testlink.sourceforge.net/ *}
{* $Id: reqSpecAnalyse.tpl,v 1.7 2008/09/22 19:14:08 schlundus Exp $ *}
{* Purpose: smarty template - Analyse REQ coverage *}

{lang_get var="labels"
          s="req_spec,req_title_analyse,req_spec_change,edit,req_total_count,req_title_in_tl,
             req_title_covered,req_title_uncovered,req_title_not_in_tl,
             req_title_nottestable,req_title_covered,req_doc_id,req,testcases,none"}

{assign var="action_reqspec_view" value="lib/requirements/reqSpecView.php"}
{assign var="action_req_view" value="lib/requirements/reqView.php?item=requirement&amp;requirement_id="}


{include file="inc_head.tpl"}

<body>

<h1 class="title">
	{$labels.req_title_analyse}{$smarty.const.TITLE_SEP}{$reqSpec[$selectedReqSpec]|escape}
	{include file="inc_help.tpl" helptopic="hlp_requirementsCoverage"}
</h1>


<div class="workBack">
{include file="inc_update.tpl" result=$sqlResult action=$action}

<div>
<form method="get">{$labels.req_spec_change}
	<select name="req_spec_id" onchange="form.submit()">
	{html_options options=$reqSpec selected=$selectedReqSpec}</select>
	<span class="bold"><a href="{$action_reqspec_view}?req_spec_id={$selectedReqSpec}">{$labels.edit}</a></span>
</form>
</div>

{* METRICS *}
<table class="invisible">
<tr><td>{$labels.req_total_count}</td><td>{$metrics.expectedTotal}</td></tr>
<tr><td>{$labels.req_title_in_tl}</td><td>{$metrics.total}</td></tr>
<tr><td>{$labels.req_title_covered}</td><td>{$metrics.covered}</td></tr>
<tr><td>{$labels.req_title_uncovered}</td><td>{$metrics.total-$metrics.covered}</td></tr>
<tr><td>{$labels.req_title_not_in_tl}</td><td>{$metrics.uncovered}</td></tr>
<tr><td>{$labels.req_title_nottestable}</td><td>{$metrics.notTestable}</td></tr>
</table>

</div>


<div class="workBack">
<h2>{$labels.req_title_covered} - {$metrics.coveredTestPlan}</h2>

{section name=row loop=$coverage.covered}
{if $smarty.section.row.first}
<table class="simple">
	<tr>

		<th>{lang_get s="req_doc_id"}</th>
		<th>{lang_get s="req"}</th>
		<th>{lang_get s="testcases"}</th>
	</tr>
{/if}
	<tr>
		<td><span class="bold"><a href="{$action_req_view}{$coverage.covered[row].id}">
			{$coverage.covered[row].req_doc_id|escape}</a></span></td>
			<td><span class="bold"><a href="{$action_req_view}{$coverage.covered[row].id}">
			{$coverage.covered[row].title|escape}</a></span></td>
		<td>{section name=subrow loop=$coverage.covered[row].coverage}
    <a href="lib/testcases/archiveData.php?id={$coverage.covered[row].coverage[subrow].id|escape}&amp;edit=testcase&allow_edit=0">{$tcprefix|escape}{$coverage.covered[row].coverage[subrow].tc_external_id}</a>:{$coverage.covered[row].coverage[subrow].name|escape}<br />
		{/section}</td>
	</tr>
{if $smarty.section.row.last}
</table>
{/if}
{sectionelse}
	<p class="bold">{$labels.none}</p>
{/section}
</div>


<div class="workBack">
<h2>{$labels.req_title_uncovered} - {$metrics.coveredTestPlan}</h2>
{section name=row2 loop=$coverage.uncovered}
{if $smarty.section.row2.first}
<table class="simple">
	<tr>
		<th>{lang_get s="req_doc_id"}</th>
		<th>{lang_get s="req"}</th>
	</tr>
{/if}
	<tr>
		<td><span class="bold"><a href="{$action_req_view}{$coverage.uncovered[row2].id}">{$coverage.uncovered[row2].req_doc_id|escape}</a></span></td>
		<td><span class="bold"><a href="{$action_req_view}{$coverage.uncovered[row2].id}">{$coverage.uncovered[row2].title|escape}</a></span></td>
	</tr>
{if $smarty.section.row2.last}
</table>
{/if}
{sectionelse}
	<p class="bold">{$labels.none}</p>
{/section}
</div>

<div class="workBack">
<h2>{$labels.req_title_nottestable}</h2>

{section name=row3 loop=$coverage.nottestable}
{if $smarty.section.row3.first}
<table class="simple">
	<tr>
		<th>{lang_get s="req"}</th>
	</tr>
{/if}
	<tr>
		<td><span class="bold"><a href="{$action_req_view}{$coverage.nottestable[row3].id}">
			{$coverage.nottestable[row3].title|escape}</a></span></td>
	</tr>
{if $smarty.section.row3.last}
</table>
{/if}
{sectionelse}
	<p class="bold">{$labels.none}</p>
{/section}
</div>


</body>
</html>

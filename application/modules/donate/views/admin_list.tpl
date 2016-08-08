{if $type == "paypal"}
	{foreach from=$results item=log}
		<li>
			<table width="100%" style="font-size:11px;">
				<tr>
					<td width="13%">{date("Y/m/d", $log.timestamp)}</td>
					<td width="13%">
						<a href="{$url}admin/accounts/get/{$log.user_id}" target="_blank">
							{$log.nickname}
						</a>
					</td>
					
					<td width="13%" {if !$log.validated}style="text-decoration:line-through"{/if}>
						<b>
							{$log.payment_amount} {$log.payment_currency}
						</b>
					</td>

					{if $log.validated}
						<td width="15%" >{$log.payment_status}</td>
					{else}
						<td width="15%" data-tip="{$log.error}" style="color:red;cursor:pointer;">
							Error (?)
						</td>
					{/if}

					<td data-tip="Transaction ID: {$log.txn_id}" style="font-size:11px;">{$log.payer_email}</td>
				
					{if !$log.validated}<td><a class="nice_button" style="float:right;" href="javascript:void(0)" onClick="Donate.give({$log.id}, this)">Give DP</a></td>{/if}
				</tr>
			</table>
		</li>
	{/foreach}
{elseif $type == "paygol"}
	{foreach from=$results item=log}
		<li>
			<table width="100%" style="font-size:11px;">
				<tr>
					<td width="15%">{date("Y/m/d", $log.timestamp)}</td>
					<td width="13%">
						<a href="{$url}admin/accounts/get/{$log.custom}" target="_blank">
							{$log.nickname}
						</a>
					</td>
					<td width="15%"><b>{round($log.price)} {$log.currency}</b></td>
					<td width="15%">{$log.operator}</td>
					<td width="10%"><img src="{$url}application/images/flags/{strtolower($log.country)}.png" data-tip="{$log.country}" style="opacity:1;"/></td>
					<td data-tip="Message ID: {$log.message_id}">{$log.sender}</td>
				</tr>
			</table>
		</li>
	{/foreach}
{elseif $type == "paymentwall"}
	{foreach from=$results item=log}
		<li>
			<table width="100%" style="font-size:11px;">
				<tr>
					<td>{date("Y/m/d", $log.timestamp)}</td>
					<td>
						<a href="{$url}admin/accounts/get/{$log.user_id}" target="_blank">
							{$log.nickname}
						</a>
					</td>
					<td><b>{$log.dp_amount} DP</b></td>
					<td>
						Status: 
						{if $log.status == 'success'}
							<span style="display:inline;color:green">Success</span>
						{else}
							<span style="display:inline;color:red">Failed</span>
						{/if}
					</td>
					<td>
						Type:
						{if $log.type == 0}
							Credit
						{elseif $log.type == 1}
							Credit (courtesy)
						{elseif $log.type == 2}
							Chargeback
						{/if}
					</td>
				</tr>
			</table>
		</li>
	{/foreach}
{/if}
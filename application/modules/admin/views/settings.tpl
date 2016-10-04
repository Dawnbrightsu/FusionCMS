<section class="box big" id="realm_settings">
	<h2><img src="{$url}application/themes/admin/images/icons/black16x16/ic_cloud.png"/> ریلم ها (<div style="display:inline;" id="realm_count">{count($realms)}</div>)</h2>
	<span>
		<div dir="rtl" align="right" style="float:right;" data-tip="این اولین شبیه سازی است که شما انتخاب کرده اید"><b dir="rtl" align="right">شبیه ساز و نوع آن :</b> {strtoupper($realms[0]->getConfig("emulator"))}</div>
		<a class="nice_button" href="javascript:void(0)" onClick="Settings.showAddRealm()">افزودن ریلم جدید</a>
	</span>
	<ul id="realm_list">
		{foreach from=$realms item=realm}
			<li>
				<table width="100%">
					<tr>
						<td width="10%">ID: {$realm->getId()}</td>
						<td width="30%"><b>{$realm->getName()}</b></td>
						<td width="30%">{$realm->getConfig("hostname")}</td>
						<td width="20%">{strtoupper($realm->getConfig("emulator"))}</td>
						<td style="text-align:right;">
							<a href="{$url}admin/realmmanager/edit/{$realm->getId()}" data-tip="ویرایش"><img src="{$url}application/themes/admin/images/icons/black16x16/ic_edit.png" /></a>&nbsp;
							<a href="javascript:void(0)" onClick="Settings.remove({$realm->getId()}, this)" data-tip="حذف"><img src="{$url}application/themes/admin/images/icons/black16x16/ic_minus.png" /></a>
						</td>
					</tr>
				</table>
			</li>
		{/foreach}
	</ul>
</section>

<div id="add_realm" style="display:none;">
	<section class="box big">
		<h2><a href='javascript:void(0)' onClick="Settings.showAddRealm()" data-tip="بازگشت به تنظیمات">تنظیمات</a> &rarr; ریلم جدید</h2>

		<form onSubmit="Settings.addRealm(); return false">
			<label dir="rtl" align="right" for="realmName">نام ریلم</label>
			<input type="text" id="realmName" />

			<label for="realmName" dir="rtl" align="right">آی پی محل سرور</label>
			<input type="text" id="hostname" />

			<label>Server structure (mainly for the bigger private servers with clustered hosts)</label>
			<select id="server_structure" onChange="Settings.changeStructure(this)">
				<option value="1" selected>[All in one] I host emulator and both characters and world databases on the same server (default)</option>
				<option value="2">[Emulator and databases separated] I host the emulator on one server and the databases on another</option>
				<option value="3">[All separate] I host emulator, world and characters on three different servers</option>
			</select>

			<div id="one">
				<label for="username" dir="rtl" align="right">نام کاربری دیتابیس</label>
				<input type="text" id="username" />

				<label for="password" dir="rtl" align="right">رمز عبور دیتابیس</label>
				<input type="password" id="password" />
			</div>

			<div id="two" style="display:none;">
				<label for="override_hostname_char">Characters &amp; world: database hostname</label>
				<input type="text" id="override_hostname_char" />

				<label for="override_username_char">Characters &amp; world: database username</label>
				<input type="text" id="override_username_char" />

				<label for="override_password_char">Characters &amp; world: database password</label>
				<input type="password" id="override_password_char" />

				<label for="override_port_char">Characters &amp; world: database port</label>
				<input type="text" id="override_port_char" value="3306" />
			</div>

			<div id="three" style="display:none;">
				<label for="override_hostname_char_three">Characters: database hostname</label>
				<input type="text" id="override_hostname_char_three" />

				<label for="override_username_char_three">Characters: database username</label>
				<input type="text" id="override_username_char_three" />

				<label for="override_password_char_three">Characters: database password</label>
				<input type="password" id="override_password_char_three" />

				<label for="override_port_char_three">Characters: database port</label>
				<input type="text" id="override_port_char_three" value="3306" />

				<label for="override_hostname_world_three">World: database hostname</label>
				<input type="text" id="override_hostname_world_three" />

				<label for="override_username_world_three">World: database username</label>
				<input type="text" id="override_username_world_three" />

				<label for="override_password_world_three">World: database password</label>
				<input type="password" id="override_password_world_three" />

				<label for="override_port_world_three">World: database port</label>
				<input type="text" id="override_port_world_three" value="3306" />
			</div>

			<label for="characters" dir="rtl" align="right">نام دیتابیس Characters</label>
			<input type="text" id="characters"/>

			<label for="world" dir="rtl" align="right">نام دیتابیس World</label>
			<input type="text" id="world" />

			<label for="cap" dir="rtl" align="right">حداکثر ظرفیت تعداد پلیر آنلاین ریلم</label>
			<input type="text" id="cap" />

			<label for="port" dir="rtl" align="right">پورت ریلم :</label>
			<input type="text" id="port" />


			<label for="emulator" dir="rtl" align="right">شبیه ساز</label>
			<select id="emulator">
				{foreach from=$emulators key=emu_id item=emu_name}
					<option value="{$emu_id}">{$emu_name}</option>
				{/foreach}
			</select>

			<label for="console_port" dir="rtl" align="right>کنسول پورت : برای دسترسی ریموت معمولا 3443 و سرویس Soap معمولا 7878 میباشد</label>
			<input type="text" id="console_port" />

			<label for="console_username" data-tip="اکانت رنک 4 به بالا در سرور<br />برای ارتباط نیاز است" dir="rtl" align="right">نام کاربری ادمین با رنک 4 (?)</label>
			<input type="text" id="console_username" />

			<label for="console_password" data-tip="اکانت رنک 4 به بالا در سرور<br />برای ارتباط نیاز است" dir="rtl" align="right">نام کاربری ادمین با رنک 4 (?)</label>
			<input type="password" id="console_password" />

			<input type="submit" value="افزودن ریلم" />
		</form>
	</section>
</div>

<div id="non_realm">
	<section class="box big">
		<h2><img src="{$url}application/themes/admin/images/icons/black16x16/ic_settings.png"/> وبسایت</h2>
		
		<form onSubmit="Settings.saveWebsiteSettings(); return false">
			<label for="title" dir="rtl" align="right">عنوان وبسایت</label>
			<input type="text" id="title" placeholder="MyServer" value="{$config.title}" />

			<label for="server_name" dir="rtl" align="right">نام سرور</label>
			<input type="text" id="server_name" placeholder="MyServer" value="{$config.server_name}" />

			<label for="realmlist" dir="rtl" align="right">ریلم لیست</label>
			<input type="text" id="realmlist" placeholder="logon.myserver.com" value="{$config.realmlist}" />

			<label for="disabled_expansions" dir="rtl" align="right">پچ</label>
			<select id="disabled_expansions">
				<option value="legion" {if count($config.disabled_expansions) == 0}selected{/if}>Legion</option>
				<option value="wod" {if count($config.disabled_expansions) == 1}selected{/if}>Warlords of Draenor</option>
				<option value="mop" {if count($config.disabled_expansions) == 2}selected{/if}>Mists Of Pandaria</option>
				<option value="cata" {if count($config.disabled_expansions) == 3}selected{/if}>Cataclysm</option>
				<option value="wotlk" {if count($config.disabled_expansions) == 4}selected{/if}>Wrath of the Lich King</option>
				<option value="tbc" {if count($config.disabled_expansions) == 5}selected{/if}>The Burning Crusade</option>
				<option value="none" {if count($config.disabled_expansions) == 6}selected{/if}>No expansion allowed</option>
			</select>

			<label for="keywords" dir="rtl" align="right">موتور جستجو:  کلمات کلیدی و با کاما جدا شود.</label>
			<input type="text" id="keywords" placeholder="world of warcraft,wow,private server,pvp,yekta-core,yekta-wow" value="{$config.keywords}" />

			<label for="description" dir="rtl" align="right">موتور جستجو:  توضیحات</label>
			<input type="text" id="description" placeholder="Best World of Warcraft private server in the entire world!" value="{$config.description}" />

			<label for="analytics" dir="rtl" align="right"><a href="http://analytics.google.com" target="_blank">آنالیزگر گوگل</a> آی دی وبسایت برای وضعیت پیشرفته</label>
			<input type="text" id="analytics" placeholder="XX-YYYYYYYY-Z" value="{$config.analytics}"/>

			<label for="vote_reminder" dir="rtl" align="right">فعال کردن یاد آوری پنجره Vote دادن</label>
			<select id="vote_reminder" onChange="Settings.toggleVoteReminder(this)">
				<option value="1" {if $config.vote_reminder}selected{/if}>بله</option>
				<option value="0" {if !$config.vote_reminder}selected{/if}>خیر</option>
			</select>

			<div id="vote_reminder_settings" {if !$config.vote_reminder}style="display:none;"{/if}>
				<label for="vote_reminder_image" dir="rtl" align="right">آدرس تصویر برای یاد آوری Vote</label>
				<input type="text" id="vote_reminder_image" placeholder="http://mywebsite.com/images/banner.gif" value="{$config.vote_reminder_image}"/>

				<label for="reminder_interval" dir="rtl" align="right">فاصله یادآوری Vote (در ساعت)</label>
				<input type="text" id="reminder_interval" value="{$config.reminder_interval/60/24}" placeholder="12" />
			</div>

			<label for="cdn" dir="rtl" align="right">استفاده از شبکه های تحویل محتوا برای کتابخانه جاوا اسکریپت (برای شبکه های LAN غیرفعال کنید.)</label>
			<select id="cdn">
				<option value="1" {if $config.cdn}selected{/if}>بله</option>
				<option value="0" {if !$config.cdn}selected{/if}>خیر</option>
			</select>

			<label for="has_smtp" dir="rtl" align="right">فعال سازی بخش بازگردانی رمز عبور (نیاز به SMTP سرور دارد)</label>
			<select id="has_smtp">
				<option value="1" {if $config.has_smtp}selected{/if}>بله</option>
				<option value="0" {if !$config.has_smtp}selected{/if}>خیر</option>
			</select>


			<input type="submit" value="ذخیره تنظیمات" />

			<center id="website_ajax"></center>
		</form>
	</section>

	<section class="box big">
		<h2><img src="{$url}application/themes/admin/images/icons/black16x16/ic_settings.png"/>تنظیمات SMTP ایمیل</h2>
		
		<form onSubmit="Settings.saveSmtpSettings(); return false">
			<label for="use_own_smtp_settings" dir="rtl" align="right">استفاده از تنظیمات SMTP خود (آنها را در زیر وارد کنید)</label>
			<select id="use_own_smtp_settings">
				<option value="1" {if $smtp.use_own_smtp_settings}selected{/if}>بله</option>
				<option value="0" {if !$smtp.use_own_smtp_settings}selected{/if}>خیر</option>
			</select>

			<label for="smtp_host" dir="rtl" align="right">محل SMTP</label>
			<input type="text" id="smtp_host" value="{$smtp.smtp_host}" />

			<label for="smtp_user" dir="rtl" align="right">نام کاربری SMTP</label>
			<input type="text" id="smtp_user" value="{$smtp.smtp_user}" />

			<label for="smtp_pass" dir="rtl" align="right">رمز عبور SMTP</label>
			<input type="text" id="smtp_pass" value="{$smtp.smtp_pass}" />

			<label for="smtp_port" dir="rtl" align="right">پورت SMTP</label>
			<input type="text" id="smtp_port" value="{$smtp.smtp_port}" />

			<input type="submit" value="ذخیره تنظیمات" />

			<center id="smtp_ajax"></center>
		</form>
	</section>

	<section class="box big">
		<h2><img src="{$url}application/themes/admin/images/icons/black16x16/ic_power.png"/> تنظیمات عملکرد</h2>
		
		<form onSubmit="Settings.savePerformanceSettings(); return false">

			<label dir="rtl" align="right" for="disable_visitor_graph" data-tip="اگر شما میخواهید نمودار بازدید در پنل ادمین را غیر فعال کنید بله را انتخاب کنید">غیر فعال کردن نمودار بازدید کننده داشبورد (؟)</a></label>
			<select name="disable_visitor_graph" id="disable_visitor_graph">
				<option value="1" {if $config.disable_visitor_graph}selected{/if}>بله</option>
				<option value="0" {if !$config.disable_visitor_graph}selected{/if}>خیر</option>
			</select>

			<input type="submit" value="ذخیره تنظیمات" />

			<center id="performance_ajax"></center>
		</form>
	</section>
</div>

package game.mechanics.clan_war.popup.members
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ActiveClanWarMembersPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.clan.editicon.ClanIconClip;
   
   public class ActiveClanWarMembersPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ActiveClanWarMembersPopupMediator;
      
      private var clip:ActiveClanWarMembersPopupClip;
      
      private var icon:ClanIconClip;
      
      private var list:GameScrolledList;
      
      public function ActiveClanWarMembersPopup(param1:ActiveClanWarMembersPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.triesLeftTotal.unsubscribe(handler_triesLeftTotal);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(ActiveClanWarMembersPopupClip,"dialog_active_clan_war_members");
         addChild(clip.graphics);
         height = 500;
         clip.button_close.signal_click.add(mediator.close);
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         var _loc3_:* = 0.7;
         icon.graphics.scaleY = _loc3_;
         icon.graphics.scaleX = _loc3_;
         clip.layout_banner.addChild(icon.graphics);
         AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.clan.icon);
         clip.tf_guild_name.text = mediator.clan.title;
         clip.points_tf.text = mediator.pointsEarned.toString();
         clip.title_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_TITLE");
         clip.desc_tf.text = Translate.translateArgs("UI_CLAN_WAR_MEMBERS_DESC",mediator.title_master,mediator.title_warlord,mediator.maxWarriorCount);
         clip.member_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_MEMBER");
         clip.attempts_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_ATTEMPTS");
         clip.commands_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_DESENSE_COMMANDS");
         mediator.triesLeftTotal.onValue(handler_triesLeftTotal);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc3_ = 10;
         _loc1_.paddingBottom = _loc3_;
         _loc1_.paddingTop = _loc3_;
         _loc1_.gap = 4;
         list = new GameScrolledList(_loc2_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.layout = _loc1_;
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         list.itemRendererType = ActiveClanWarMemberItemRenderer;
         clip.list_container.container.addChild(list);
         list.dataProvider = new ListCollection(mediator.members);
      }
      
      private function handler_triesLeftTotal(param1:int) : void
      {
         clip.attempts_counter_tf.text = "(" + param1 + "/" + mediator.triesMax + ")";
      }
   }
}

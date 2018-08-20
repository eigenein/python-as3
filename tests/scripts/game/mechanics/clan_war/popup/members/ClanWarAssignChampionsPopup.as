package game.mechanics.clan_war.popup.members
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.renderers.LayoutGroupListItemRenderer;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarAssignChampionsPopupMediator;
   import game.mechanics.clan_war.model.ClanWarMemberFullInfoValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.clan.editicon.ClanIconClip;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class ClanWarAssignChampionsPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanWarAssignChampionsPopupMediator;
      
      private var clip:ClanWarAssignChampionsPopupClip;
      
      private var icon:ClanIconClip;
      
      private var list:GameScrolledList;
      
      public function ClanWarAssignChampionsPopup(param1:ClanWarAssignChampionsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.playerClan.signal_iconUpdated.remove(handler_iconUpdated);
         mediator.signal_countWarriorsChanged.remove(handler_countWarriorsChanged);
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(ClanWarAssignChampionsPopupClip,"dialog_clan_war_members");
         addChild(clip.graphics);
         height = 550;
         clip.button_close.signal_click.add(mediator.close);
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         var _loc3_:* = 0.7;
         icon.graphics.scaleY = _loc3_;
         icon.graphics.scaleX = _loc3_;
         clip.layout_banner.addChild(icon.graphics);
         handler_iconUpdated();
         mediator.playerClan.signal_iconUpdated.add(handler_iconUpdated);
         mediator.signal_countWarriorsChanged.add(handler_countWarriorsChanged);
         clip.tf_guild_name.text = mediator.playerClan.title;
         clip.title_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_TITLE");
         clip.desc_tf.text = Translate.translateArgs("UI_CLAN_WAR_MEMBERS_DESC",mediator.title_master,mediator.title_warlord,mediator.maxWarriorCount);
         clip.member_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_MEMBER");
         clip.status_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_STATUS");
         clip.commands_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_DESENSE_COMMANDS");
         handler_countWarriorsChanged();
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
         clip.list_container.container.addChild(list);
         mediator.property_playerPermission_defenseManagement.onValue(handler_playerPermission_defenseManagement);
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         list.dataProvider = mediator.members;
      }
      
      private function handler_playerPermission_defenseManagement(param1:Boolean) : void
      {
         if(param1)
         {
            list.itemRendererType = ClanWarMemberItemRendererEditable;
         }
         else
         {
            list.itemRendererType = ClanWarMemberItemRenderer;
         }
      }
      
      private function onListRendererAdded(param1:Event, param2:LayoutGroupListItemRenderer) : void
      {
         if(param2 is ClanWarMemberItemRendererEditable)
         {
            (param2 as ClanWarMemberItemRendererEditable).signal_updateSelectedState.add(handler_clanWarMemberItemRendererUpdateState);
         }
      }
      
      private function onListRendererRemoved(param1:Event, param2:LayoutGroupListItemRenderer) : void
      {
         if(param2 is ClanWarMemberItemRendererEditable)
         {
            (param2 as ClanWarMemberItemRendererEditable).signal_updateSelectedState.remove(handler_clanWarMemberItemRendererUpdateState);
         }
      }
      
      private function handler_clanWarMemberItemRendererUpdateState(param1:ClanWarMemberFullInfoValueObject, param2:Boolean) : void
      {
         mediator.action_clanWarEnableWarrior(param1,param2);
      }
      
      private function handler_iconUpdated() : void
      {
         AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.playerClan.icon);
      }
      
      private function handler_countWarriorsChanged() : void
      {
         var _loc1_:* = null;
         if(mediator.countWarriors >= mediator.maxWarriorCount)
         {
            _loc1_ = ColorUtils.hexToRGBFormat(8841550);
         }
         else
         {
            _loc1_ = ColorUtils.hexToRGBFormat(11220276);
         }
         clip.status_counter_tf.text = ColorUtils.hexToRGBFormat(16645626) + "(" + _loc1_ + mediator.countWarriors + ColorUtils.hexToRGBFormat(16645626) + "/" + mediator.maxWarriorCount + ")";
      }
   }
}

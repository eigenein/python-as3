package game.view.popup.clan.role
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanEditRolePopupMediator;
   import game.view.popup.PopupBase;
   
   public class ClanEditRolePopup extends PopupBase
   {
       
      
      private var mediator:ClanEditRolePopupMediator;
      
      public function ClanEditRolePopup(param1:ClanEditRolePopupMediator)
      {
         super();
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         var _loc3_:ClanEditRolePopupClip = AssetStorage.rsx.popup_theme.create(ClanEditRolePopupClip,"clan_edit_role_popup");
         addChild(_loc3_.graphics);
         width = _loc3_.bg.graphics.width;
         height = _loc3_.bg.graphics.height;
         _loc3_.button_close.signal_click.add(close);
         if(mediator.rank2.code > mediator.rank3.code)
         {
            _loc3_.layout_buttons.addChildAt(_loc3_.button_rank_2.graphics,1);
         }
         else
         {
            _loc3_.layout_buttons.addChildAt(_loc3_.button_rank_3.graphics,1);
         }
         _loc3_.button_rank_1.signal_click.add(mediator.action_rankOne);
         _loc3_.button_rank_2.signal_click.add(mediator.action_rankTwo);
         _loc3_.button_rank_3.signal_click.add(mediator.action_rankThree);
         var _loc1_:int = _loc3_.role_info.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(mediator.data.length > _loc2_)
            {
               _loc3_.role_info[_loc2_].setData(mediator.data[_loc2_]);
            }
            else
            {
               _loc3_.role_info[_loc2_].graphics.visible = false;
            }
            _loc2_++;
         }
         _loc3_.tf_nickname.text = mediator.nickname;
         _loc3_.tf_level.text = mediator.currentRole;
         _loc3_.tf_rank_1.text = mediator.roles[0].roleName;
         _loc3_.tf_rank_2.text = mediator.roles[1].roleName;
         _loc3_.tf_rank_3.text = mediator.roles[2].roleName;
         _loc3_.tf_rank_4.text = mediator.roles[3].roleName;
         _loc3_.tf_message.text = Translate.translate("UI_POPUP_CLAN_ROLE_CHANGE");
         _loc3_.portrait.setData(mediator.userInfo);
         _loc3_.button_rank_1.label = mediator.rank1.roleName;
         _loc3_.button_rank_2.label = mediator.rank2.roleName;
         _loc3_.button_rank_3.label = mediator.rank3.roleName;
      }
   }
}

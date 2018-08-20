package game.view.popup.clan
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanPublicInfoPopupClip extends PopupClipBase
   {
       
      
      public var button_join:ClipButtonLabeled;
      
      public var member_list:ClanInfoPopupMemberList;
      
      public var layout_banner:ClipLayout;
      
      public var tf_guild_name:ClipLabel;
      
      public var tf_members:SpecialClipLabel;
      
      public var tf_min_level:SpecialClipLabel;
      
      public var tf_not_enough_lvl:ClipLabel;
      
      public var layout_bottom:ClipLayout;
      
      public function ClanPublicInfoPopupClip()
      {
         button_join = new ClipButtonLabeled();
         member_list = new ClanInfoPopupMemberList();
         layout_banner = ClipLayout.none();
         tf_guild_name = new ClipLabel(true);
         tf_members = new SpecialClipLabel();
         tf_min_level = new SpecialClipLabel();
         tf_not_enough_lvl = new ClipLabel();
         layout_bottom = ClipLayout.verticalMiddleCenter(-2,button_join,tf_not_enough_lvl);
         super();
      }
   }
}

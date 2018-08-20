package game.view.popup.clan
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanInfoPopupClip extends PopupClipBase
   {
       
      
      public var button_log:ClipButtonLabeled;
      
      public var button_leave:ClipButtonLabeled;
      
      public var layout_banner:ClipLayout;
      
      public var tf_guild_name:ClipLabel;
      
      public var tf_members:SpecialClipLabel;
      
      public var member_list:ClanInfoPopupMemberList;
      
      public function ClanInfoPopupClip()
      {
         button_log = new ClipButtonLabeled();
         button_leave = new ClipButtonLabeled();
         layout_banner = ClipLayout.none();
         tf_guild_name = new ClipLabel(true);
         tf_members = new SpecialClipLabel();
         member_list = new ClanInfoPopupMemberList();
         super();
      }
   }
}

package game.view.popup.clan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   
   public class ClanSearchPopupClip extends PopupClipBase
   {
       
      
      public var button_create:ClipButtonLabeled;
      
      public var btn_search:ClipButtonLabeled;
      
      public var tf_list_header_1:ClipLabel;
      
      public var tf_list_header_2:ClipLabel;
      
      public var tf_name_input:ClipInput;
      
      public var tf_list_friends_empty:ClipLabel;
      
      public var tf_list_search_result_empty:ClipLabel;
      
      public var searchIcon_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var clan_list_friends:ClanSearchListClip;
      
      public var clan_list_search:ClanSearchListClip;
      
      public var search_bg:GuiClipScale9Image;
      
      public function ClanSearchPopupClip()
      {
         button_create = new ClipButtonLabeled();
         btn_search = new ClipButtonLabeled();
         tf_list_header_1 = new ClipLabel();
         tf_list_header_2 = new ClipLabel();
         tf_name_input = new ClipInput();
         tf_list_friends_empty = new ClipLabel();
         tf_list_search_result_empty = new ClipLabel();
         searchIcon_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         clan_list_friends = new ClanSearchListClip();
         clan_list_search = new ClanSearchListClip();
         search_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}

package game.view.popup.clan.editicon
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipList;
   
   public class ClanEditIconColorList extends GuiClipNestedContainer
   {
       
      
      public var list:ClipList;
      
      public var item:ClipDataProvider;
      
      public var button_left:ClipButton;
      
      public var button_right:ClipButton;
      
      public function ClanEditIconColorList()
      {
         list = new ClipList(ClipListItemClanEditIconColor);
         item = list.itemClipProvider;
         super();
      }
   }
}

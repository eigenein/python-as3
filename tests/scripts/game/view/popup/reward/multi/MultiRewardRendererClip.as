package game.view.popup.reward.multi
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipList;
   
   public class MultiRewardRendererClip extends GuiClipNestedContainer
   {
       
      
      public var layout_item_list:ClipList;
      
      public var list_item:ClipDataProvider;
      
      public var tf_caption:ClipLabel;
      
      public var tf_empty:ClipLabel;
      
      public function MultiRewardRendererClip()
      {
         layout_item_list = new ClipList(InventoryItemRenderer);
         list_item = layout_item_list.itemClipProvider;
         tf_caption = new ClipLabel();
         tf_empty = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_item_list.list.layout = new HorizontalLayout();
      }
   }
}

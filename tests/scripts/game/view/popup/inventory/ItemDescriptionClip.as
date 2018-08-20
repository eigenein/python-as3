package game.view.popup.inventory
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import flash.geom.Rectangle;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipList;
   import game.view.popup.hero.slot.ClipListItemBattleStat;
   
   public class ItemDescriptionClip extends GuiClipNestedContainer
   {
       
      
      public var hero_desc:HeroDescriptionInventoryClip;
      
      public var tf_item_desc_text:ClipLabel;
      
      public var stats_list:ClipList;
      
      public var stats_item:ClipDataProvider;
      
      public var desc_bg:GuiClipScale9Image;
      
      public function ItemDescriptionClip()
      {
         hero_desc = new HeroDescriptionInventoryClip();
         tf_item_desc_text = new ClipLabel();
         stats_list = new ClipList(ClipListItemBattleStat);
         stats_item = stats_list.itemClipProvider;
         desc_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function setData(param1:InventoryItem, param2:Vector.<BattleStatValueObject>) : void
      {
         tf_item_desc_text.visible = false;
         hero_desc.graphics.visible = false;
         stats_list.graphics.visible = false;
         if(param1.item is UnitDescription)
         {
            hero_desc.graphics.visible = true;
            hero_desc.setData(param1.item as UnitDescription);
            desc_bg.graphics.height = 200;
         }
         else if(param2)
         {
            stats_list.list.dataProvider = new ListCollection(param2);
            desc_bg.graphics.height = stats_list.graphics.height + 10;
            stats_list.graphics.visible = true;
         }
         else
         {
            tf_item_desc_text.visible = true;
            tf_item_desc_text.text = param1.descText;
            tf_item_desc_text.validate();
            desc_bg.graphics.height = tf_item_desc_text.height + 25;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         stats_list.list.layout = new VerticalLayout();
      }
   }
}

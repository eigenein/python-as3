package game.mechanics.dungeon.popup.list
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.list.ItemList;
   
   public class DungeonRoomList extends ItemList
   {
       
      
      private var _property_scrollValue:IntPropertyWriteable;
      
      public function DungeonRoomList()
      {
         _property_scrollValue = new IntPropertyWriteable();
         super();
      }
      
      public function get property_scrollValue() : IntProperty
      {
         return _property_scrollValue;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.useVirtualLayout = true;
         layout = _loc1_;
         _loc1_.gap = 300;
         itemRendererType = DungeonRoomItemRenderer;
         verticalScrollPolicy = "off";
         throwEase = "easeInOut";
         if(true)
         {
            horizontalScrollPolicy = "off";
            verticalScrollPolicy = "off";
         }
      }
      
      override protected function draw() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}

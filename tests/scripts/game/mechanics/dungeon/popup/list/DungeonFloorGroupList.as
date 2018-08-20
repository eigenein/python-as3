package game.mechanics.dungeon.popup.list
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.controls.List;
   import feathers.layout.VerticalLayout;
   
   public class DungeonFloorGroupList extends List
   {
       
      
      private var _property_verticalScrollPosition:IntPropertyWriteable;
      
      public function DungeonFloorGroupList()
      {
         _property_verticalScrollPosition = new IntPropertyWriteable();
         super();
      }
      
      public function get property_verticalScrollPosition() : IntProperty
      {
         return _property_verticalScrollPosition;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.useVirtualLayout = true;
         _loc1_.paddingBottom = 0;
         _loc1_.gap = 650;
         layout = _loc1_;
         itemRendererType = DungeonFloorGroupRenderer;
         verticalMouseWheelScrollStep = 163.333333333333;
         horizontalScrollPolicy = "off";
         if(true)
         {
            horizontalScrollPolicy = "off";
            verticalScrollPolicy = "off";
         }
         hasElasticEdges = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = this.isInvalid("scroll");
         super.draw();
         if(_loc1_)
         {
            _property_verticalScrollPosition.value = int(verticalScrollPosition);
         }
      }
   }
}

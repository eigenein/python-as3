package game.mediator.gui.popup.billing
{
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import engine.core.utils.property.VectorConcatProperty;
   import engine.core.utils.property.VectorProperty;
   
   public class PopupSideBarMediator
   {
       
      
      protected const _dataSources:VectorConcatProperty = new VectorConcatProperty();
      
      protected const _currentBlock:ObjectPropertyWriteable = new ObjectPropertyWriteable(SideBarBlockValueObject,SideBarBlockValueObject.EMPTY);
      
      public function PopupSideBarMediator()
      {
         super();
         _dataSources.onValue(handler_dataUpdated);
      }
      
      public function dispose() : void
      {
         _dataSources.dispose();
      }
      
      public function addValueObjectSource(param1:VectorProperty) : void
      {
         _dataSources.addVectors(param1);
      }
      
      public function addStaticValueObject(param1:SideBarBlockValueObject) : void
      {
         _dataSources.addVectors(VectorProperty.fromOneElemement(param1));
      }
      
      public function get currentBlock() : ObjectProperty
      {
         return _currentBlock;
      }
      
      protected function handler_dataUpdated(param1:Vector.<SideBarBlockValueObject>) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = SideBarBlockValueObject.getMaxPriority(param1);
            if(_loc2_ == null)
            {
               _loc2_ = SideBarBlockValueObject.EMPTY;
            }
         }
         else
         {
            _loc2_ = SideBarBlockValueObject.EMPTY;
         }
         _currentBlock.value = _loc2_;
      }
   }
}

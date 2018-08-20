package game.view.gui.debug
{
   import feathers.controls.Label;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class StringItem extends ListItemRenderer
   {
       
      
      protected var label:Label;
      
      public function StringItem()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         invalidate("data");
         invalidate();
         validate();
      }
      
      override protected function commitData() : void
      {
         label.text = String(data);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         label = new Label();
         label.textRendererProperties.textFormat = LogStyleFactory.instance.monospaceFontFormat;
         addChild(label);
      }
   }
}

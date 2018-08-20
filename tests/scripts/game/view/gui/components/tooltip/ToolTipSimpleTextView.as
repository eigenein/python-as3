package game.view.gui.components.tooltip
{
   import feathers.controls.Label;
   import feathers.text.BitmapFontTextFormat;
   import game.assets.storage.AssetStorage;
   
   public class ToolTipSimpleTextView extends TooltipTextView
   {
       
      
      public function ToolTipSimpleTextView()
      {
         super();
      }
      
      override protected function createElements() : void
      {
         _label = new Label();
         _label.textRendererProperties.textFormat = new BitmapFontTextFormat(AssetStorage.font.Officina16_multiline);
         _label.wordWrap = true;
         _label.maxWidth = 450;
         addChild(_label);
      }
   }
}

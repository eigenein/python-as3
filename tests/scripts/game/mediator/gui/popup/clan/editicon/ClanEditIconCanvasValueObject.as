package game.mediator.gui.popup.clan.editicon
{
   import game.mediator.gui.popup.clan.ClanEditIconPopupMediator;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class ClanEditIconCanvasValueObject extends ClanEditIconValueObject
   {
       
      
      private var _colorPatternTexture:Texture;
      
      private var _squareColorPatternTexture:Texture;
      
      private var mediator:ClanEditIconPopupMediator;
      
      public function ClanEditIconCanvasValueObject(param1:int, param2:ClanEditIconPopupMediator, param3:Texture, param4:Texture)
      {
         super(param1);
         this.mediator = param2;
         this._colorPatternTexture = param3;
         this._squareColorPatternTexture = param4;
      }
      
      public function dispose() : void
      {
      }
      
      public function get signal_graphicsUpdated() : Signal
      {
         return mediator.signal_canvasUpdated;
      }
      
      public function get colorPatternTexture() : Texture
      {
         return _colorPatternTexture;
      }
      
      public function get squareColorPatternTexture() : Texture
      {
         return _squareColorPatternTexture;
      }
      
      public function get color1() : uint
      {
         return mediator.color1.color;
      }
      
      public function get color2() : uint
      {
         return mediator.color2.color;
      }
   }
}

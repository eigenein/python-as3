package game.battle.view
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.filters.DisplacementMapFilter;
   import starling.textures.RenderTexture;
   import starling.textures.TextureMemoryManager;
   
   public class BattleScenePostprocessing
   {
      
      public static const DISPLACEMENT_0:int = 128;
      
      private static const scaleX:Number = 100;
      
      private static const scaleY:Number = 100;
      
      private static const MAX_TEXTURE_SIZE:int = 2048;
       
      
      private var target:DisplayObjectContainer;
      
      private var blurFilter:BlurFilter;
      
      private var displacementFilter:DisplacementMapFilter;
      
      private var needBlurFilter:Boolean;
      
      private var fxTransform:Matrix;
      
      private var canUseRenderTexture:Boolean = false;
      
      private var needUpdateRenderTexture:Boolean = false;
      
      private var renderTexture:RenderTexture;
      
      private var point:Point;
      
      public const displacmentAffectorsContainer:Sprite = new Sprite();
      
      public function BattleScenePostprocessing(param1:DisplayObjectContainer)
      {
         super();
         this.target = param1;
         Game.instance.screen.size.onValue(handler_setSize);
         fxTransform = new Matrix(1,0,0,1,0,400);
      }
      
      public function dispose() : void
      {
         if(renderTexture)
         {
            renderTexture.dispose();
            renderTexture = null;
         }
         if(displacementFilter)
         {
            displacementFilter.dispose();
            displacementFilter = null;
         }
         if(blurFilter)
         {
            blurFilter.dispose();
            blurFilter = null;
         }
         target = null;
      }
      
      public function update() : void
      {
         var _loc2_:* = false;
         var _loc1_:* = false;
         if(target == null)
         {
            return;
         }
         if(needBlurFilter)
         {
            target.filter = blurFilter;
         }
         else
         {
            _loc2_ = displacmentAffectorsContainer.numChildren > 0;
            if(_loc2_ && canUseRenderTexture)
            {
               if(needUpdateRenderTexture)
               {
                  updateRenderTexture();
               }
               else
               {
                  clearRenderTexture();
               }
               fxTransform.ty = 400;
               renderTexture.draw(displacmentAffectorsContainer,fxTransform);
            }
            _loc1_ = target.filter == displacementFilter;
            if(_loc1_ != _loc2_)
            {
               target.filter = !!_loc2_?displacementFilter:null;
            }
         }
      }
      
      public function setBlur() : void
      {
         needBlurFilter = true;
         if(!blurFilter)
         {
            blurFilter = new BlurFilter(2,2,0.5);
         }
      }
      
      public function clearRenderTexture() : void
      {
         renderTexture.clear(128 * 65793);
      }
      
      private function updateRenderTexture() : void
      {
         needUpdateRenderTexture = false;
         var _loc1_:Number = Game.instance.screen.size.width;
         var _loc2_:Number = Game.instance.screen.size.height;
         if(renderTexture)
         {
            if(renderTexture.width == _loc1_ && renderTexture.height == _loc2_)
            {
               return;
            }
            renderTexture.dispose();
         }
         renderTexture = new RenderTexture(_loc1_,_loc2_);
         renderTexture.clear(128 * 65793);
         TextureMemoryManager.add(renderTexture,"battleScenePostprocessing " + _loc1_ + "x" + _loc2_);
         updateDisplacementFilter();
      }
      
      private function updateDisplacementFilter() : void
      {
         if(displacementFilter == null)
         {
            displacementFilter = new DisplacementMapFilter(renderTexture,point,1,2,100,100);
         }
         else
         {
            displacementFilter.mapTexture = renderTexture;
         }
      }
      
      private function handler_setSize(param1:Number, param2:Number) : void
      {
         canUseRenderTexture = param1 <= 2048 && param2 <= 2048;
         needUpdateRenderTexture = true;
      }
   }
}

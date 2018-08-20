package starling.custom
{
   import flash.display3D.Context3D;
   import flash.display3D.IndexBuffer3D;
   import flash.display3D.VertexBuffer3D;
   import starling.core.Starling;
   import starling.core.StatsDisplay;
   import starling.display.QuadBatch;
   import starling.errors.MissingContextError;
   
   public class ByteQuadBatchBuffers
   {
      
      private static const DATA_32_PER_VERTEX:int = 5;
      
      private static const BYTES_PER_QUAD:int = 80;
       
      
      private var _buffersNumQuad:int = 0;
      
      private var _bytesNumQuad:int = 0;
      
      private var _numQuadsToUpload:int = 0;
      
      private const indexData:Vector.<uint> = new Vector.<uint>();
      
      var vertexBuffer:VertexBuffer3D;
      
      var indexBuffer:IndexBuffer3D;
      
      public const vertexBytes:DomainMemoryByteArray = new DomainMemoryByteArray();
      
      public function ByteQuadBatchBuffers()
      {
         super();
         Starling.current.stage3D.addEventListener("context3DCreate",onContextCreated,false,0,true);
      }
      
      public function dispose() : void
      {
         Starling.current.stage3D.removeEventListener("context3DCreate",onContextCreated);
         tryDestroyBuffers();
      }
      
      public function requestCapacity(param1:int) : void
      {
         if(param1 > _bytesNumQuad)
         {
            _bytesNumQuad = param1;
            vertexBytes.setReadyForSize(param1 * 80);
         }
         else
         {
            _numQuadsToUpload = param1;
            vertexBytes.setReadyForSize(param1 * 80);
         }
      }
      
      public function sync() : void
      {
         if(_bytesNumQuad > _buffersNumQuad)
         {
            _buffersNumQuad = _bytesNumQuad;
            recreateBuffers();
         }
         if(_numQuadsToUpload > 0)
         {
            vertexBuffer.uploadFromByteArray(vertexBytes.byteArray,0,0,_numQuadsToUpload * 4);
            _numQuadsToUpload = 0;
         }
      }
      
      protected function recreateBuffers() : void
      {
         var _loc6_:* = 0;
         tryDestroyBuffers();
         var _loc4_:Context3D = Starling.context;
         if(_loc4_ == null)
         {
            throw new MissingContextError();
         }
         if(_loc4_.driverInfo == "Disposed")
         {
            throw new MissingContextError("context3d is currently disposed in QBB");
         }
         var _loc2_:int = indexData.length / 6;
         var _loc3_:int = _buffersNumQuad;
         var _loc5_:int = _buffersNumQuad * 6;
         indexData.length = _loc5_;
         _loc6_ = _loc2_;
         while(_loc6_ < _loc3_)
         {
            indexData[int(_loc6_ * 6)] = _loc6_ * 4;
            indexData[int(_loc6_ * 6 + 1)] = _loc6_ * 4 + 1;
            indexData[int(_loc6_ * 6 + 2)] = _loc6_ * 4 + 2;
            indexData[int(_loc6_ * 6 + 3)] = _loc6_ * 4 + 1;
            indexData[int(_loc6_ * 6 + 4)] = _loc6_ * 4 + 3;
            indexData[int(_loc6_ * 6 + 5)] = _loc6_ * 4 + 2;
            _loc6_++;
         }
         indexBuffer = Starling.context.createIndexBuffer(_loc5_);
         indexBuffer.uploadFromVector(indexData,0,_loc5_);
         QuadBatch.vertexBufferCount++;
         StatsDisplay.customOutput.VTB = QuadBatch.vertexBufferCount;
         var _loc1_:int = QuadBatch.vertexBufferCount;
         vertexBuffer = _loc4_.createVertexBuffer(_buffersNumQuad * 4,5);
         _numQuadsToUpload = _loc3_;
      }
      
      protected function tryDestroyBuffers() : void
      {
         if(indexBuffer)
         {
            indexBuffer.dispose();
            indexBuffer = null;
         }
         if(vertexBuffer)
         {
            QuadBatch.vertexBufferCount--;
            StatsDisplay.customOutput.VTB = QuadBatch.vertexBufferCount;
            vertexBuffer.dispose();
            vertexBuffer = null;
         }
      }
      
      private function onContextCreated(param1:Object) : void
      {
         _buffersNumQuad = 0;
      }
   }
}

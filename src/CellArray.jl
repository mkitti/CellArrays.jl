import CellArraysCore: CellArraysCore, CellArray, CPUCellArray,_N, Cell, cellsize, blocklength, field, check_T
using CellArraysCore.StaticArrays, CellArraysCore.Adapt, CUDA, AMDGPU

"""
    CuCellArray{T<:Cell,N,B,T_elem} <: AbstractArray{T,N} where Cell <: Union{Number, SArray, FieldArray}

`N`-dimensional CellArray with cells of type `T`, blocklength `B`, and `T_array` being a `CuArray` of element type `T_elem`: alias for `CellArray{T,N,B,CuArray{T_elem,CellArrays._N}}`.

--------------------------------------------------------------------------------

    CuCellArray{T,B}(undef, dims)
    CuCellArray{T}(undef, dims)

Construct an uninitialized `N`-dimensional `CellArray` containing `Cells` of type `T` which are stored in an array of kind `CuArray`.

See also: [`CellArray`](@ref), [`CPUCellArray`](@ref), [`ROCCellArray`](@ref)
"""
CuCellArray{T,N,B,T_elem} = CellArray{T,N,B,CuArray{T_elem,_N}}


"""
    ROCCellArray{T<:Cell,N,B,T_elem} <: AbstractArray{T,N} where Cell <: Union{Number, SArray, FieldArray}

`N`-dimensional CellArray with cells of type `T`, blocklength `B`, and `T_array` being a `ROCArray` of element type `T_elem`: alias for `CellArray{T,N,B,ROCArray{T_elem,CellArrays._N}}`.

--------------------------------------------------------------------------------

    ROCCellArray{T,B}(undef, dims)
    ROCCellArray{T}(undef, dims)

Construct an uninitialized `N`-dimensional `CellArray` containing `Cells` of type `T` which are stored in an array of kind `ROCArray`.

See also: [`CellArray`](@ref), [`CPUCellArray`](@ref), [`CuCellArray`](@ref)
"""
ROCCellArray{T,N,B,T_elem} = CellArray{T,N,B,ROCArray{T_elem,_N}}

 CuCellArray{T,B}(::UndefInitializer, dims::NTuple{N,Int}) where {T<:Cell,N,B} = (check_T(T); CuCellArray{T,N,B,eltype(T)}(undef, dims))
ROCCellArray{T,B}(::UndefInitializer, dims::NTuple{N,Int}) where {T<:Cell,N,B} = (check_T(T); ROCCellArray{T,N,B,eltype(T)}(undef, dims))

 CuCellArray{T,B}(::UndefInitializer, dims::Int...) where {T<:Cell,B} = CuCellArray{T,B}(undef, dims)
ROCCellArray{T,B}(::UndefInitializer, dims::Int...) where {T<:Cell,B} = ROCCellArray{T,B}(undef, dims)

 CuCellArray{T}(::UndefInitializer, dims::NTuple{N,Int}) where {T<:Cell,N} = CuCellArray{T,0}(undef, dims)
ROCCellArray{T}(::UndefInitializer, dims::NTuple{N,Int}) where {T<:Cell,N} = ROCCellArray{T,0}(undef, dims)

 CuCellArray{T}(::UndefInitializer, dims::Int...) where {T<:Cell} = CuCellArray{T}(undef, dims)
ROCCellArray{T}(::UndefInitializer, dims::Int...) where {T<:Cell} = ROCCellArray{T}(undef, dims)

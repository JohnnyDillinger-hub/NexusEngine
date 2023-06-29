#include "Ray.hpp"

#include "glm/glm.hpp"

//-------------------------------------------------------------------------------------------------

Ray::Ray() = default;

//-------------------------------------------------------------------------------------------------

Ray::Ray(glm::vec3 const & origin_, glm::vec3 const & direction_)
    : mOrigin(origin_)
    , mDirection(glm::normalize(direction_))
{}

//-------------------------------------------------------------------------------------------------

glm::vec3 Ray::At(float t) const {
    return mOrigin + mDirection * t;
}

//-------------------------------------------------------------------------------------------------

glm::vec3 Ray::GetOrigin() const {
    return mOrigin;
}

//-------------------------------------------------------------------------------------------------

glm::vec3 Ray::GetDirection() const {
    return mDirection;
}

//-------------------------------------------------------------------------------------------------